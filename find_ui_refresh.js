// Frida script to find UI refresh functions in Zenless Zone Zero
// Usage: frida -n "ZenlessZoneZero.exe" -l find_ui_refresh.js

console.log("[*] Starting Il2Cpp function search...");

// Wait for GameAssembly.dll to load
var gameAssembly = Process.getModuleByName("GameAssembly.dll");
console.log("[+] GameAssembly.dll base: " + gameAssembly.base);

// Search for specific function names in exports
console.log("[*] Searching exports for UI/Localization functions...");

var exports = gameAssembly.enumerateExports();
var found = [];

exports.forEach(function (exp) {
    var name = exp.name.toLowerCase();

    // Search for UI refresh related functions
    if (name.includes("refresh") ||
        name.includes("update") ||
        name.includes("language") ||
        name.includes("localization") ||
        name.includes("text")) {

        console.log("[!] Found: " + exp.name + " at " + exp.address);
        found.push({
            name: exp.name,
            address: exp.address,
            rva: exp.address.sub(gameAssembly.base)
        });
    }
});

console.log("\n[*] Summary:");
console.log("[*] Found " + found.length + " potential functions");

if (found.length > 0) {
    console.log("\n[*] Top candidates:");
    found.forEach(function (f) {
        console.log("  - " + f.name);
        console.log("    RVA: 0x" + f.rva.toString(16));
        console.log("    Address: " + f.address);
    });
} else {
    console.log("[!] No obvious UI refresh functions found in exports");
    console.log("[*] The game might be using Il2Cpp with stripped symbols");
    console.log("[*] Try using Il2CppInspector or runtime hooking instead");
}

console.log("\n[*] Script completed. Press Ctrl+C to exit.");
