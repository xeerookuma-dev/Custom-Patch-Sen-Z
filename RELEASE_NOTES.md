# 📦 Custom-Patch-Sen-Z-V2 Release

## 🇹🇭 คำอธิบาย (Thai)

### 📋 ไฟล์ในแพ็คเกจนี้

- **xeekuma.dll** - ไฟล์ DLL หลักที่ใช้ inject เข้าเกม
- **xeeroookuma.exe** - Injector สำหรับโหลด DLL เข้าเกม
- **custom** - ไฟล์ข้อความกำหนดเอง (แก้ไขได้)
- **README.txt** - คู่มือการใช้งาน

### 🚀 วิธีติดตั้ง

1. **แตกไฟล์ zip** ไปที่ folder เกม Zenless Zone Zero
   - ตัวอย่าง: `E:\Program Files\.PSClients\Sen-Z_PS\CNBetaWin2.6.x\`
   
2. **ตรวจสอบไฟล์** ให้แน่ใจว่ามีไฟล์ทั้ง 3 อยู่ใน folder เกม:
   - ✅ `xeekuma.dll`
   - ✅ `xeeroookuma.exe`
   - ✅ `custom`

3. **รัน Injector**
   - เปิดเกม Zenless Zone Zero ก่อน
   - รัน `xeeroookuma.exe`
   - รอจนกว่าจะเห็นข้อความ "Injection successful"

4. **เช็คข้อความ**
   - กลับไปที่เกม
   - คุณจะเห็นข้อความกำหนดเองปรากฏในเกม

### ✏️ การแก้ไขข้อความ

#### วิธีที่ 1: แก้ไขไฟล์โดยตรง (ง่าย แต่ต้อง refresh)
1. เปิดไฟล์ `custom` ด้วย Notepad
2. แก้ไขข้อความตามต้องการ
3. บันทึกไฟล์
4. **เปลี่ยนภาษาในเกม** (EN → 中文 → EN) เพื่อ refresh UI
5. ข้อความจะอัพเดท

#### วิธีที่ 2: Rebuild (แนะนำสำหรับนักพัฒนา)
1. โหลด source code จาก GitHub
2. แก้ไข `src/custom`
3. รัน `zig build`
4. คัดลอก `zig-out/bin/xeekuma.dll` ใหม่มาแทนที่
5. รีสตาร์ทเกม

### 🎨 การใช้ Rich Text

ไฟล์ `custom` รองรับ Unity Rich Text tags:

```
<color=#ff0000>ข้อความสีแดง</color>
<color=#00ff00>ข้อความสีเขียว</color>
<color=#0000ff>ข้อความสีน้ำเงิน</color>
<b>ตัวหนา</b>
<i>ตัวเอียง</i>
```

**ตัวอย่าง:**
```
<color=#ff0000>นี่คือเวอร์ชั่นทดสอบ</color> <color=#00ff00>Zenless Zone Zero</color> | <color=#FFFFFF>xeeroookuma</color>
```

### - ⚠️ ใช้เพื่อการศึกษาเท่านั้น

**ปัญหา: ข้อความไม่แสดง**
- ✅ ตรวจสอบว่าไฟล์ `custom` อยู่ใน folder เกม
- ✅ ลองเปลี่ยนภาษาในเกม

---

## 🇬🇧 Description (English)

### 📋 Files in this Package

- **xeekuma.dll** - Main DLL file to inject into the game
- **xeeroookuma.exe** - Injector to load DLL into the game
- **custom** - Custom message file (editable)
- **README.txt** - User guide

### 🚀 Installation

1. **Extract zip** to your Zenless Zone Zero game folder
   - Example: `E:\Program Files\.PSClients\Sen-Z_PS\CNBetaWin2.6.x\`
   
2. **Verify files** - Make sure all 3 files are in the game folder:
   - ✅ `xeekuma.dll`
   - ✅ `xeeroookuma.exe`
   - ✅ `custom`

3. **Run Injector**
   - Open Zenless Zone Zero first
   - Run `xeeroookuma.exe`
   - Wait for "Injection successful" message

4. **Check Message**
   - Return to the game
   - You'll see your custom message appear

### ✏️ Editing Messages

#### Method 1: Direct File Edit (Easy, but needs refresh)
1. Open `custom` file with Notepad
2. Edit the message as desired
3. Save the file
4. **Change language in-game** (EN → 中文 → EN) to refresh UI
5. Message will update

#### Method 2: Rebuild (Recommended for developers)
1. Download source code from GitHub
2. Edit `src/custom`
3. Run `zig build`
4. Copy new `zig-out/bin/xeekuma.dll` to replace old one
5. Restart game

### 🎨 Using Rich Text

The `custom` file supports Unity Rich Text tags:

```
<color=#ff0000>Red text</color>
<color=#00ff00>Green text</color>
<color=#0000ff>Blue text</color>
<b>Bold text</b>
<i>Italic text</i>
```

**Example:**
```
<color=#ff0000>This is a test version</color> <color=#00ff00>Zenless Zone Zero</color> | <color=#FFFFFF>xeeroookuma</color>
```

### ⚠️ Warnings

- ⚠️ For educational purposes only
- ⚠️ May be detected by anti-cheat (use at your own risk)
- ⚠️ Backup your data before use
- ⚠️ Not responsible for any damages

### 🔧 Troubleshooting

**Problem: Injector doesn't work**
- ✅ Check if game is running
- ✅ Run injector as Administrator
- ✅ Temporarily disable antivirus

**Problem: Message doesn't show**
- ✅ Verify `custom` file is in game folder
- ✅ Try changing language in-game
- ✅ Restart game and inject again

**Problem: Game crashes**
- ✅ Check if using correct DLL version
- ✅ Remove DLL and restart game

---

## 📞 Support

- **GitHub**: https://github.com/xeeroookuma/Custom-Patch-Sen-Z-V2
- **Developer**: xeeroookuma
- **Version**: 2.0

## 📜 License

For educational purposes only. Use at your own risk.
