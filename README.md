# Custom-Patch-Sen-Z-V2

Custom message patch for Zenless Zone Zero with editable external file support.

## Features

✅ **Editable Custom Message**
- Message loaded from external `custom` file
- Edit message anytime without rebuilding
- No hardcoded strings in binary

✅ **Simple & Clean**
- Minimal code changes
- Easy to maintain
- Stable and reliable

## How to Use

### 1. Build
```powershell
zig build
```

### 2. Run
Copy `zig-out/bin/xeekuma.dll` to game directory and run the injector.

### 3. Edit Message
Edit the `custom` file in the game directory with your message.

### 4. Refresh
**Change language in game settings** (e.g., English → 中文 → English) to see the updated message.

## Why Language Change?

The game caches UI text separately. After extensive testing:
- ❌ Real-time file watching doesn't trigger UI refresh
- ❌ Memory scanning and pointer replacement ineffective
- ❌ Il2Cpp metadata is encrypted (can't find UI refresh function easily)

**Language change** is the only reliable way to refresh UI without deep reverse engineering.

## Technical Details

- **Language**: Zig 0.15.2
- **Target**: Zenless Zone Zero (Il2Cpp Unity game)
- **Method**: DLL injection with function hooking
- **Message Storage**: External `custom` file (editable post-build)

## File Structure

```
Custom-Patch-Sen-Z-V2/
├── src/
│   ├── root.zig          # Main entry point
│   ├── crypto.zig        # RSA crypto hooks & message loading
│   ├── network.zig       # Network request hooks
│   └── util.zig          # Utility functions
├── assets/
│   ├── offsets           # Memory offsets
│   ├── sdk_public_key.xml
│   └── server_public_key.xml
├── injector.zig          # DLL injector
└── build.zig             # Build configuration
```

## Credits

- **Developer**: xeeroookuma
- **Framework**: Zig + zigzag
- **Game**: Zenless Zone Zero by miHoYo

## License

For educational purposes only.
