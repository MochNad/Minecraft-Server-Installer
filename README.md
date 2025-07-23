<div align="center">

# 🎮 Minecraft Server Auto Installer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-18.04+-orange.svg)](https://ubuntu.com/)
[![Minecraft](https://img.shields.io/badge/Minecraft-Multiple%20Versions-green.svg)](https://minecraft.net/)

**Automated Minecraft server installer with Docker support for multiple versions and server types**

[Quick Start](#-quick-start) • [Installation](#-installation) • [Features](#-features) • [Server Types](#-server-types)

</div>

---

## 🚀 Quick Start

Deploy your **Minecraft server** in **under 5 minutes** with interactive configuration:

```bash
curl -fsSL https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh | sudo bash
```

## 📋 System Requirements

| Component   | Minimum                    | Recommended       |
| ----------- | -------------------------- | ----------------- |
| **OS**      | Ubuntu 18.04+ / Debian 10+ | Ubuntu 20.04+     |
| **RAM**     | 1GB                        | 4GB+              |
| **Storage** | 10GB free space            | 25GB+             |
| **CPU**     | 1 core                     | 4 cores+          |
| **Network** | Custom port open           | Stable connection |

## ⚡ Installation Methods

### Method 1: One-Line Installation (Recommended)

```bash
# Download and execute automatically
curl -fsSL https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh | sudo bash
```

### Method 2: Manual Download

```bash
# Download script
wget https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh

# Make executable and run
chmod +x install-minecraft-docker.sh
sudo ./install-minecraft-docker.sh
```

### Method 3: Git Clone

```bash
# Clone repository
git clone https://github.com/MochNad/minecraft-server-installer.git
cd minecraft-server-installer

# Execute installer
chmod +x install-minecraft-docker.sh
sudo ./install-minecraft-docker.sh
```

## 🎯 Features

### ✨ Core Features

- 🔄 **Fully Automated**: Interactive configuration with smart defaults
- 🐳 **Docker-based**: Containerized for better isolation and management
- 🌐 **Cracked Support**: Optional offline mode for cracked clients
- ⚡ **Performance Optimized**: Aikar flags and configurable memory allocation
- 🔒 **Security**: Automatic firewall configuration with SSH protection
- 🎮 **Multi-Version**: Support for multiple Minecraft versions
- 🔧 **Multi-Type**: Support for various server types

### 🎮 Supported Versions

| Version     | Status         | Description               |
| ----------- | -------------- | ------------------------- |
| **latest**  | ✅ Recommended | Newest stable version     |
| **1.21.81** | ✅ Available   | Latest bedrock compatible |
| **1.21.7**  | ✅ Available   | Stable release            |
| **1.21.4**  | ✅ Available   | Previous stable           |
| **1.21.1**  | ✅ Available   | LTS support               |
| **1.20.4**  | ✅ Available   | Popular version           |
| **1.19.4**  | ✅ Available   | Legacy support            |
| **1.18.2**  | ✅ Available   | Classic version           |
| **1.16.5**  | ✅ Available   | Modded favorite           |

### 🔧 Server Types

| Type        | Description                    | Best For          |
| ----------- | ------------------------------ | ----------------- |
| **VANILLA** | Official Minecraft server      | Pure experience   |
| **FORGE**   | Mod support framework          | Heavy modding     |
| **FABRIC**  | Lightweight mod loader         | Performance mods  |
| **PAPER**   | High-performance Spigot fork   | Large servers     |
| **SPIGOT**  | Plugin-based server            | Custom plugins    |
| **PURPUR**  | Paper fork with extra features | Advanced features |
| **MOHIST**  | Forge + Bukkit hybrid          | Mods + Plugins    |

## 📊 Interactive Configuration

The installer provides an interactive setup where you can configure:

```
🎯 Minecraft Version Selection (1-9 options)
⚡ Server Type Selection (7 options)
🌐 Custom Port Configuration (default: 25565)
🔓 Cracked Player Support (optional)
👥 Maximum Players (1-200)
💾 Memory Allocation (1GB-Custom)
```

### Example Configuration Output

```yaml
📋 Configuration Summary:
├── Version: 1.21.7
├── Type: FORGE
├── Port: 25565
├── Cracked Support: ENABLED
├── Max Players: 20
└── Memory: 2G (limit: 3G)
```

## 🛠️ Server Management

### Basic Commands

```bash
# Check server status
docker ps

# View live logs
cd /opt/minecraft-server && docker compose logs -f

# Server console access
docker attach minecraft-server

# Check server details
docker inspect minecraft-server
```

### Control Commands

```bash
# Stop server
cd /opt/minecraft-server && docker compose down

# Start server
cd /opt/minecraft-server && docker compose up -d

# Restart server
cd /opt/minecraft-server && docker compose restart

# Update server
cd /opt/minecraft-server && docker compose pull && docker compose up -d
```

### Advanced Management

```bash
# Access server files
docker exec -it minecraft-server bash

# Backup world data
docker cp minecraft-server:/data/world ./backup-world-$(date +%Y%m%d)/

# View resource usage
docker stats minecraft-server

# Edit server properties
docker exec -it minecraft-server nano /data/server.properties
```

## 🔧 Mod and Plugin Management

### For Modded Servers (Forge/Fabric)

```bash
# Add mods
docker cp yourmod.jar minecraft-server:/data/mods/

# List installed mods
docker exec minecraft-server ls -la /data/mods/

# Remove a mod
docker exec minecraft-server rm /data/mods/unwanted-mod.jar
```

### For Plugin Servers (Paper/Spigot/Purpur)

```bash
# Add plugins
docker cp yourplugin.jar minecraft-server:/data/plugins/

# List installed plugins
docker exec minecraft-server ls -la /data/plugins/

# Remove a plugin
docker exec minecraft-server rm /data/plugins/unwanted-plugin.jar
```

## 🔐 Security Features

- ✅ **SSH Protection**: Automatic SSH access protection during firewall setup
- ✅ **UFW Firewall**: Auto-configured with secure defaults
- ✅ **Port Management**: Only necessary ports (22, custom) are opened
- ✅ **Docker Isolation**: Server runs in isolated container
- ✅ **RCON Security**: Configurable RCON access with password protection

## 🔍 Troubleshooting

### Common Issues

<details>
<summary>🔧 Server Won't Start</summary>

```bash
# Check container status
docker ps -a

# View startup logs
docker logs minecraft-server

# Check for common issues
docker logs minecraft-server | grep -i "error\|exception"

# Restart with fresh configuration
cd /opt/minecraft-server && docker compose down && docker compose up -d
```

</details>

<details>
<summary>🎮 Connection Issues</summary>

```bash
# Check server status
docker ps | grep minecraft

# Verify port is open
sudo ufw status | grep YOUR_PORT

# Test server connectivity
telnet YOUR_SERVER_IP YOUR_PORT

# Check if server is accepting connections
docker logs minecraft-server | grep -i "done\|started"
```

</details>

<details>
<summary>💾 Performance Issues</summary>

```bash
# Check memory usage
docker stats minecraft-server

# View current configuration
cd /opt/minecraft-server && cat docker-compose.yml

# Increase memory allocation (edit docker-compose.yml)
sudo nano /opt/minecraft-server/docker-compose.yml
# Change MEMORY: "2G" to desired amount

# Restart with new settings
docker compose restart
```

</details>

<details>
<summary>🔄 Update Issues</summary>

```bash
# Force update to latest image
cd /opt/minecraft-server
docker compose down
docker compose pull
docker compose up -d

# Rollback if needed
docker compose down
docker run --rm -v minecraft-data:/data alpine rm -rf /data/server.jar
docker compose up -d
```

</details>

## 📁 File Structure

```
/opt/minecraft-server/
├── docker-compose.yml      # Main configuration
└── data/                   # Server data volume
    ├── world/              # Main world
    ├── server.properties   # Server configuration
    ├── ops.json           # Operator list
    ├── whitelist.json     # Whitelist (if enabled)
    ├── logs/              # Server logs
    ├── mods/              # Mods (Forge/Fabric)
    ├── plugins/           # Plugins (Paper/Spigot)
    └── config/            # Configuration files
```

## 📈 Performance Monitoring

```bash
# Real-time resource monitoring
docker stats minecraft-server

# Check server TPS (in-game command for supported servers)
tps

# Monitor server performance
docker logs minecraft-server | grep -i "performance\|lag\|tick"

# Check startup time
docker logs minecraft-server | grep -i "done\|started"
```

## 🚀 Quick Commands Reference

```bash
# Essential Commands
cd /opt/minecraft-server && docker compose logs -f  # View logs
docker attach minecraft-server                      # Server console
cd /opt/minecraft-server && docker compose restart  # Restart

# File Management
docker cp file.jar minecraft-server:/data/mods/     # Add mod
docker cp file.jar minecraft-server:/data/plugins/  # Add plugin
docker exec minecraft-server ls /data/              # List files

# Backup & Restore
docker cp minecraft-server:/data/world ./backup/    # Backup world
docker cp minecraft-server:/data/ ./full-backup/    # Full backup
```

## 🎮 Server Type Specific Features

### Forge Servers

- Full mod support with automatic Forge installation
- Mod compatibility checking
- Forge-specific optimization flags

### Fabric Servers

- Lightweight mod loading
- Better performance optimization
- Modern mod ecosystem support

### Paper/Spigot Servers

- Plugin support with Bukkit/Spigot API
- Advanced performance features
- Anti-cheat and security enhancements

### Vanilla Servers

- Pure Minecraft experience
- No modifications or plugins
- Official server behavior

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test with different server types and versions
4. Submit a pull request

## 📞 Support

- 📧 **Issues**: [GitHub Issues](https://github.com/MochNad/minecraft-server-installer/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/MochNad/minecraft-server-installer/discussions)
- 🔧 **Server Support**: Check respective server type documentation

---

<div align="center">

**[⬆ Back to Top](#-minecraft-server-auto-installer)**

Made with ❤️ for the Minecraft community

</div>
