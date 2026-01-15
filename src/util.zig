const root = @import("root");
const std = @import("std");

pub fn readCSharpString(data: usize) []u16 {
    const len = @as(*const u32, @ptrFromInt(data + 16)).*;
    const ptr = @as([*]u16, @ptrFromInt(data + 20));
    return ptr[0..len];
}

pub fn csharpStringReplace(object: usize, pattern: []const u16, replacement: []const u16, startIndex: usize) void {
    const str = readCSharpString(object);

    // Copy replacement text
    @memcpy(str[startIndex .. startIndex + replacement.len], replacement);

    // Manual copy for overlapping memory (replacement for @memmove)
    const src_start = startIndex + pattern.len;
    const dst_start = startIndex + replacement.len;
    const copy_len = str.len - src_start;

    if (copy_len > 0) {
        var i: usize = 0;
        while (i < copy_len) : (i += 1) {
            str[dst_start + i] = str[src_start + i];
        }
    }

    // Update string length
    @as(*u32, @ptrFromInt(object + 16)).* = @intCast(str.len - (pattern.len - replacement.len));
}

pub fn ptrToStringAnsi(str: []const u8) usize {
    return @as(*const fn ([*]const u8) callconv(.c) usize, @ptrFromInt(root.base + root.offsets.unwrapOffset(.PTR_TO_STRING_ANSI)))(str.ptr);
}

pub fn updateCSharpString(object: usize, new_content: []const u8) void {
    const len_ptr = @as(*u32, @ptrFromInt(object + 16));
    const data_ptr = @as([*]u16, @ptrFromInt(object + 20));

    var utf16_len: usize = 0;
    var it = std.unicode.Utf8View.init(new_content) catch return;
    var iter = it.iterator();
    while (iter.nextCodepoint()) |cp| {
        if (cp < 0x10000) {
            data_ptr[utf16_len] = @intCast(cp);
            utf16_len += 1;
        } else {
            const high = @as(u16, @intCast((cp - 0x10000) >> 10)) + 0xD800;
            const low = @as(u16, @intCast((cp - 0x10000) & 0x3FF)) + 0xDC00;
            data_ptr[utf16_len] = high;
            data_ptr[utf16_len + 1] = low;
            utf16_len += 2;
        }
    }
    len_ptr.* = @intCast(utf16_len);
    data_ptr[utf16_len] = 0; // Null terminator for compatibility
}

// ===================== Deep Scan Memory Utilities =====================
const windows = std.os.windows;

pub fn scanAndReplacePointers(old_ptr: usize, new_ptr: usize) void {
    var mbi: windows.MEMORY_BASIC_INFORMATION = undefined;
    var address: usize = 0;

    // Scan writable memory regions
    while (true) {
        const query_result = windows.VirtualQuery(@ptrFromInt(address), &mbi, @sizeOf(windows.MEMORY_BASIC_INFORMATION)) catch break;
        if (query_result == 0) break;
        // Only scan committed, writable pages (skip read-only, guard pages, etc.)
        if (mbi.State == windows.MEM_COMMIT and
            (mbi.Protect == windows.PAGE_READWRITE or mbi.Protect == windows.PAGE_EXECUTE_READWRITE))
        {
            const region_start = @intFromPtr(mbi.BaseAddress);
            const region_size = mbi.RegionSize;

            // Skip our own buffers to avoid infinite loops
            if (region_start == old_ptr or region_start == new_ptr) {
                address = region_start + region_size;
                continue;
            }

            // Scan this region for the old pointer
            scanRegionAndReplace(region_start, region_size, old_ptr, new_ptr);
        }

        address = @intFromPtr(mbi.BaseAddress) + mbi.RegionSize;

        // Safety: stop if we've scanned too far (prevent infinite loops)
        if (address >= 0x7FFFFFFF0000) break;
    }
}

fn scanRegionAndReplace(start: usize, size: usize, old_ptr: usize, new_ptr: usize) void {
    const ptr_size = @sizeOf(usize);
    var offset: usize = 0;

    while (offset + ptr_size <= size) : (offset += ptr_size) {
        const check_addr = start + offset;
        const value_ptr = @as(*usize, @ptrFromInt(check_addr));

        // Check if this location contains our old pointer
        if (value_ptr.* == old_ptr) {
            // Replace it with the new pointer
            value_ptr.* = new_ptr;
            std.log.debug("Replaced pointer at 0x{X}: 0x{X} -> 0x{X}", .{ check_addr, old_ptr, new_ptr });
        }
    }
}
