// Advanced Frida script to find UI refresh function
// Usage: frida -n "ZenlessZoneZero.exe" -l find_ui_refresh_advanced.js

console.log("[*] Attaching to ZenlessZoneZero.exe...");
console.log("[*] Attaching to ZenlessZoneZeroBeta.exe...");

// Wait for GameAssembly.dll
var gameAssembly = null;
var attempts = 0;

function waitForGameAssembly() {
    try {
        gameAssembly = Process.getModuleByName("GameAssembly.dll");
        console.log("[+] GameAssembly.dll found at: " + gameAssembly.base);
        startMonitoring();
    } catch (e) {
        attempts++;
        if (attempts < 10) {
            console.log("[*] Waiting for GameAssembly.dll... (" + attempts + "/10)");
            setTimeout(waitForGameAssembly, 1000);
        } else {
            console.log("[!] Failed to find GameAssembly.dll");
        }
    }
}

function startMonitoring() {
    console.log("\n[*] ========================================");
    console.log("[*] INSTRUCTIONS:");
    console.log("[*] 1. Go to game settings");
    console.log("[*] 2. Change language (e.g., English -> Chinese)");
    console.log("[*] 3. Watch the console for function calls");
    console.log("[*] 4. Send ALL output to developer");
    console.log("[*] ========================================\n");

    // Hook Il2Cpp domain functions to trace calls
    hookIl2CppFunctions();

    console.log("[*] Monitoring started. Change language now!");
}

function hookIl2CppFunctions() {
    var exports = gameAssembly.enumerateExports();
    var hookedCount = 0;

    exports.forEach(function (exp) {
        var name = exp.name;

        // Hook functions that might be related to UI/Language/Text
        if (name.includes("Language") ||
            name.includes("Localization") ||
            name.includes("Refresh") ||
            name.includes("Update") ||
            name.includes("Text") ||
            name.includes("UI")) {

            try {
                Interceptor.attach(exp.address, {
                    onEnter: function (args) {
                        console.log("[CALL] " + name + " at " + exp.address);
                    }
                });
                hookedCount++;
                console.log("[+] Hooked: " + name + " at RVA: 0x" + exp.address.sub(gameAssembly.base).toString(16));
            } catch (e) {
                // Ignore hook failures
            }
        }
    });

    console.log("[*] Hooked " + hookedCount + " functions");

    if (hookedCount === 0) {
        console.log("[!] No relevant functions found in exports");
        console.log("[!] Game might be using stripped symbols");
        console.log("[!] Try using Il2CppInspector or manual reverse engineering");
    }
}

// Start
waitForGameAssembly();
