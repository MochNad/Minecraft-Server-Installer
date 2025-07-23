<div align="center">

# 🎮 Minecraft Server Auto Installer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-18.04+-orange.svg)](https://ubuntu.com/)
[![Minecraft](https://img.shields.io/badge/Minecraft-Multiple%20Versions-green.svg)](https://minecraft.net/)

**Automated Minecraft server installer with Docker support for multiple versions, server types, and multi-server management**

[Quick Start](#-quick-start) • [Installation](#-installation) • [Features](#-features) • [Server Types](#-server-types)

</div>

---

## 🚀 Quick Start

Deploy your **Minecraft server** in **under 5 minutes** with interactive configuration:

```bash
wget -O install.sh https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh
chmod +x install.sh
sudo ./install.sh
```

> ⚠️ **Security Note**: We recommend using `wget` instead of `curl -fsSL | sudo bash` for better security. Always review scripts before execution.

## 📋 System Requirements

| Component   | Minimum                    | Recommended       |
| ----------- | -------------------------- | ----------------- |
| **OS**      | Ubuntu 18.04+ / Debian 10+ | Ubuntu 20.04+     |
| **RAM**     | 1GB                        | 4GB+              |
| **Storage** | 10GB free space            | 25GB+             |
| **CPU**     | 1 core                     | 4 cores+          |
| **Network** | Custom port open           | Stable connection |

## ⚡ Installation Methods

The installer now supports two installation types:

### 🎯 Installation Types

1. **Full Installation** - Complete setup with system updates, Docker installation, firewall configuration, and server setup
2. **Add New Server Only** - Quick server addition for systems with Docker already installed

### Method 1: Secure Installation (Recommended)

```bash
# Download script safely
wget -O install.sh https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh

# Review the script (optional but recommended)
cat install.sh

# Make executable and run
chmod +x install.sh
sudo ./install.sh

# Select installation type:
# 1. Full Installation (first time users)
# 2. Add New Server Only (existing Docker users)
```

### Method 2: Manual Download

```bash
# Download script with custom name
wget -O install-minecraft-docker.sh https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh

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
- 🏷️ **Named Servers**: Custom server names for better organization
- 📁 **Multi-Server**: Run multiple servers simultaneously on different ports

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
🏷️  Server Name (custom naming for organization)
🎯 Minecraft Version Selection (1-9 options)
⚡ Server Type Selection (7 options)
🌐 Custom Port Configuration (default: 25565)
🔓 Cracked Player Support (optional)
👥 Maximum Players (1-200)
🎮 Game Mode Selection (Survival/Creative/Adventure/Spectator)
💾 Memory Allocation (1GB-Custom)
```

### 🎮 Available Game Modes

| Mode          | Description                      | Best For             |
| ------------- | -------------------------------- | -------------------- |
| **Survival**  | Gather resources, build, survive | Classic gameplay     |
| **Creative**  | Unlimited resources, flying      | Building & designing |
| **Adventure** | Custom maps, limited interaction | Story-driven content |
| **Spectator** | Observe only, no interaction     | Watching & exploring |

### Example Configuration Output

```yaml
📋 Configuration Summary:
├── Server Name: survival-server
├── Version: 1.21.7
├── Type: FORGE
├── Port: 25565
├── Cracked Support: ENABLED
├── Max Players: 20
├── Game Mode: Survival
├── Memory: 2G (limit: 3G)
└── World Name: survival-server-world
```

## 🛠️ Essential Server Management Commands

### 🎮 Basic Server Operations

```bash
# Navigate to specific server
cd /opt/minecraft-servers/YOUR_SERVER_NAME

# View all servers
ls /opt/minecraft-servers/

# Check all running containers
docker ps

# Check all containers (including stopped)
docker ps -a
```

### 📋 Server Control Commands

```bash
# Start server
cd /opt/minecraft-servers/SERVER_NAME && docker compose up -d

# Stop server
cd /opt/minecraft-servers/SERVER_NAME && docker compose down

# Restart server
cd /opt/minecraft-servers/SERVER_NAME && docker compose restart

# View server logs (real-time)
cd /opt/minecraft-servers/SERVER_NAME && docker compose logs -f

# View server logs (last 50 lines)
cd /opt/minecraft-servers/SERVER_NAME && docker compose logs --tail=50
```

### 🔧 Server Console Access

```bash
# Access server console (Ctrl+P, Ctrl+Q to detach safely)
docker attach minecraft-SERVER_NAME

# Send command to server without attaching
docker exec minecraft-SERVER_NAME rcon-cli "your-command-here"

# Execute bash in server container
docker exec -it minecraft-SERVER_NAME bash
```

### 📊 Monitoring & Status

```bash
# Check resource usage for all containers
docker stats

# Check specific server resource usage
docker stats minecraft-SERVER_NAME

# Check server startup status
docker logs minecraft-SERVER_NAME | grep -i "done\|started\|ready"

# Check for errors
docker logs minecraft-SERVER_NAME | grep -i "error\|exception\|failed"

# Check server version and type
docker exec minecraft-SERVER_NAME cat /data/version

# View server properties
docker exec minecraft-SERVER_NAME cat /data/server.properties
```

### 🔄 Server Updates & Maintenance

```bash
# Update server to latest version
cd /opt/minecraft-servers/SERVER_NAME
docker compose pull
docker compose down
docker compose up -d

# Update all servers (run from any location)
for server in /opt/minecraft-servers/*/; do
  echo "Updating $(basename "$server")..."
  cd "$server" && docker compose pull && docker compose restart
done

# View server update logs
docker logs minecraft-SERVER_NAME | grep -i "updating\|downloading"
```

### 💾 Backup & Restore Operations

```bash
# Backup specific server world
docker cp minecraft-SERVER_NAME:/data/world ./backup-SERVER_NAME-world-$(date +%Y%m%d_%H%M%S)/

# Full server backup
docker cp minecraft-SERVER_NAME:/data/ ./backup-SERVER_NAME-full-$(date +%Y%m%d_%H%M%S)/

# Backup all servers
for container in $(docker ps --format "table {{.Names}}" | grep "minecraft-"); do
  echo "Backing up $container..."
  docker cp $container:/data/ ./backup-$container-$(date +%Y%m%d_%H%M%S)/
done

# Restore world from backup
docker cp ./backup-world/ minecraft-SERVER_NAME:/data/
docker restart minecraft-SERVER_NAME
```

### 🔧 Configuration Management

```bash
# Edit server properties
docker exec -it minecraft-SERVER_NAME nano /data/server.properties

# View current configuration
docker exec minecraft-SERVER_NAME cat /data/server.properties | grep -v "^#"

# Change game mode on running server
docker exec minecraft-SERVER_NAME rcon-cli "defaultgamemode survival"
docker exec minecraft-SERVER_NAME rcon-cli "defaultgamemode creative"
docker exec minecraft-SERVER_NAME rcon-cli "defaultgamemode adventure"
docker exec minecraft-SERVER_NAME rcon-cli "defaultgamemode spectator"

# Edit docker-compose configuration
cd /opt/minecraft-servers/SERVER_NAME && nano docker-compose.yml

# Apply configuration changes
cd /opt/minecraft-servers/SERVER_NAME && docker compose restart
```

### 🎲 Mod & Plugin Management

```bash
# Add mod/plugin to server
docker cp yourfile.jar minecraft-SERVER_NAME:/data/mods/     # For modded servers
docker cp yourfile.jar minecraft-SERVER_NAME:/data/plugins/ # For plugin servers

# List installed mods
docker exec minecraft-SERVER_NAME ls -la /data/mods/

# List installed plugins
docker exec minecraft-SERVER_NAME ls -la /data/plugins/

# Remove mod/plugin
docker exec minecraft-SERVER_NAME rm /data/mods/unwanted-mod.jar
docker exec minecraft-SERVER_NAME rm /data/plugins/unwanted-plugin.jar

# Check mod/plugin compatibility
docker logs minecraft-SERVER_NAME | grep -i "mod\|plugin" | tail -20
```

### 🌐 Network & Connectivity

```bash
# Check server port status
sudo netstat -tlnp | grep :PORT_NUMBER

# Test server connectivity
telnet YOUR_SERVER_IP PORT_NUMBER

# Check firewall status
sudo ufw status

# Add new port for additional server
sudo ufw allow NEW_PORT/tcp
sudo ufw allow NEW_PORT/udp

# View all open ports
sudo ufw status numbered
```

### 🚨 Troubleshooting Commands

```bash
# Check Docker service status
sudo systemctl status docker

# Restart Docker service
sudo systemctl restart docker

# Check system resources
free -h && df -h

# View system logs for Docker
sudo journalctl -u docker.service --since "1 hour ago"

# Check container health
docker inspect minecraft-SERVER_NAME | grep -i health

# Force remove stuck container
docker rm -f minecraft-SERVER_NAME

# Clean up unused Docker resources
docker system prune -a
```

### 📈 Performance Optimization

```bash
# View Java process information
docker exec minecraft-SERVER_NAME ps aux | grep java

# Check JVM memory usage
docker exec minecraft-SERVER_NAME jstat -gc 1

# Monitor server TPS (if supported)
docker exec minecraft-SERVER_NAME rcon-cli "tps"

# View server performance stats
docker exec minecraft-SERVER_NAME rcon-cli "perf start"

# Optimize server settings
docker exec -it minecraft-SERVER_NAME nano /data/spigot.yml  # For Spigot/Paper
docker exec -it minecraft-SERVER_NAME nano /data/paper.yml   # For Paper
```

### 🎯 Quick Server Management Scripts

Create these helpful scripts for easier management:

```bash
# Create server management script
cat > ~/manage-minecraft.sh << 'EOF'
#!/bin/bash
SERVER_NAME=$1
ACTION=$2

case $ACTION in
    "start")
        cd /opt/minecraft-servers/$SERVER_NAME && docker compose up -d
        ;;
    "stop")
        cd /opt/minecraft-servers/$SERVER_NAME && docker compose down
        ;;
    "restart")
        cd /opt/minecraft-servers/$SERVER_NAME && docker compose restart
        ;;
    "logs")
        cd /opt/minecraft-servers/$SERVER_NAME && docker compose logs -f
        ;;
    "console")
        docker attach minecraft-$SERVER_NAME
        ;;
    "gamemode")
        docker exec minecraft-$SERVER_NAME rcon-cli "defaultgamemode $3"
        ;;
    *)
        echo "Usage: $0 SERVER_NAME {start|stop|restart|logs|console|gamemode MODE}"
        echo "Game modes: survival, creative, adventure, spectator"
        ;;
esac
EOF

chmod +x ~/manage-minecraft.sh

# Usage examples:
# ~/manage-minecraft.sh survival-server start
# ~/manage-minecraft.sh creative-server logs
# ~/manage-minecraft.sh pvp-server console
# ~/manage-minecraft.sh build-server gamemode creative
```

## 📁 File Structure

```
/opt/minecraft-servers/           # Multi-server directory
├── server1-name/                 # Individual server directory
│   ├── docker-compose.yml        # Server configuration
│   └── data/                     # Server data volume
│       ├── world/                # Main world
│       ├── server.properties     # Server configuration
│       ├── ops.json             # Operator list
│       ├── whitelist.json       # Whitelist (if enabled)
│       ├── logs/                # Server logs
│       ├── mods/                # Mods (Forge/Fabric)
│       ├── plugins/             # Plugins (Paper/Spigot)
│       └── config/              # Configuration files
├── server2-name/                 # Another server
│   └── ...
└── server3-name/                 # Yet another server
    └── ...
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

## 🚀 Quick Commands Reference Card

### Essential Daily Commands

```bash
# Server Status Check
docker ps | grep minecraft                          # List running servers
ls /opt/minecraft-servers/                         # List all servers

# Server Control
cd /opt/minecraft-servers/SERVER_NAME && docker compose up -d      # Start
cd /opt/minecraft-servers/SERVER_NAME && docker compose down       # Stop
cd /opt/minecraft-servers/SERVER_NAME && docker compose restart    # Restart

# Monitoring
docker stats minecraft-SERVER_NAME                 # Resource usage
docker logs minecraft-SERVER_NAME --tail=50        # Recent logs
docker attach minecraft-SERVER_NAME                # Console access

# Quick Backup
docker cp minecraft-SERVER_NAME:/data/world ./backup-$(date +%Y%m%d)/
```

### Multi-Server Management

```bash
# Start all servers
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose up -d; done

# Stop all servers
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose down; done

# Check all server status
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep minecraft

# Update all servers
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose pull && docker compose restart; done
```

---

<div align="center">

**[⬆ Back to Top](#-minecraft-server-auto-installer)**

Made with ❤️ for the Minecraft community

</div>
