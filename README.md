# Custom-Patch Sen-Z V2

A powerful and lightweight custom patch injector and network utility for game optimization and feature enhancement. Specifically designed for compatibility with "Sen Z" related projects.

## 🚀 Features

- **Real-time Patching**: Apply changes to the game without full restarts (experimental).
- **Network Optimization**: Enhanced network handling via custom crypto and network modules.
- **Discord Integration**: Automatic commit and event notifications to Discord webhooks.
- **Zig Powered**: Built with Zig for high performance and safety.
- **Cross-Platform**: Designed to work on Windows (with proper build tools).

## 🛠️ Requirements

- **Zig**: Version `0.13.0` or later (Recommended: `1.15.0`).
- **Git**: For version control and notification hooks.
- **Bash/PowerShell**: For running build scripts and notifications.

## 📦 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/xeerookuma-dev/Custom-Patch-Sen-Z-V2.git
   cd Custom-Patch-Sen-Z-V2
   ```

2. **Configure Discord Notifications** (Optional):
   - Edit `discord-notify.sh` and add your Webhook URL.
   - Set up git hooks to run the script.

## 🔨 Build Instructions

To build the project, run:

```bash
zig build
```

The output will be located in the `zig-out` directory.

## 🔗 Configuration

### Discord Webhook

The notification script `discord-notify.sh` is used to send updates to Discord. It automatically captures:
- Committer name and avatar (via GitHub).
- Commit hash and message.
- Repository and branch name.

---

*Note: This project is for educational and development purposes.*