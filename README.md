<div align="center>

# 🎮 Minecraft Server Auto Installer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-18.04+-orange.svg)](https://ubuntu.com/)
[![Minecraft](https://img.shields.io/badge/Minecraft-Java%20%26%20Bedrock-green.svg)](https://minecraft.net/)

**Automated Minecraft server installer with Docker support for Java & Bedrock editions, multiple versions, and multi-server management**

[Quick Start](#-quick-start) • [Installation](#-installation) • [Management](#-management) • [Reference](#-reference)

</div>

---

## 🚀 Quick Start

Deploy your **Minecraft server** in **under 5 minutes** with interactive configuration:

```bash
wget -O install.sh https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh
chmod +x install.sh
sudo ./install.sh
```

## 📋 Requirements

- **OS**: Ubuntu 18.04+ / Debian 10+
- **RAM**: 1GB minimum, 4GB+ recommended
- **Storage**: 10GB free space minimum
- **Network**: Stable internet connection

## ⚙️ Installation

### Installation Types

1. **Full Installation** - Complete setup (System + Docker + Firewall + Server)
2. **Add New Server** - Quick addition (requires existing Docker)

### Edition Support

- **Java Edition** - PC/Mac with mod/plugin support
- **Bedrock Edition** - Mobile, Console, Windows 10/11 cross-platform

### Configuration Options

```
💎 Edition           → Java Edition / Bedrock Edition
🏷️  Server Name       → Custom naming for organization
🎯 Version           → Predefined versions + Custom version input
⚡ Type (Java only)  → VANILLA/PAPER/FORGE/FABRIC/SPIGOT
🌐 Port             → Custom port (Java: 25565, Bedrock: 19132)
🔓 Cracked (Java)    → Enable/disable offline mode for non-premium players
🎮 Game Mode        → Survival/Creative/Adventure
💾 Memory           → 1GB-4GB allocation
```

### Edition Features

**Java Edition:**

- latest, 1.21, 1.20.4, 1.19.4, 1.18.2, 1.16.5
- **Custom**: Enter any version (e.g., 1.20.1, 1.19.2)
- **Cracked Support**: Allow non-premium players (offline mode)
- **Server Types**: VANILLA, PAPER, FORGE, FABRIC, SPIGOT
- **Mods/Plugins**: Full support for customization

**Bedrock Edition:**

- latest (stable), preview (beta)
- **Custom**: Enter any version (e.g., 1.20.40.01, 1.19.83.01)
- **Cross-platform**: Mobile, Console, Windows 10/11 compatibility
- **Always Online**: Premium accounts required (no cracked support)

## 🛠️ Management

### Basic Operations

```bash
# Navigate to server
cd /opt/minecraft-servers/SERVER_NAME

# Control server
docker compose up -d          # Start
docker compose down           # Stop
docker compose restart       # Restart
docker compose logs -f       # View logs

# Console access (Ctrl+P, Ctrl+Q to exit)
docker attach mc-SERVER_NAME

# Status check
docker ps | grep mc-
```

### Multi-Server Operations

```bash
# List servers
ls /opt/minecraft-servers/

# Start/stop all servers
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose up -d; done
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose down; done

# Check status
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep mc-
```

### Monitoring & Maintenance

```bash
# Resource monitoring
docker stats mc-SERVER_NAME

# Error checking
docker logs mc-SERVER_NAME | grep -i "error\|exception"

# Server updates
cd /opt/minecraft-servers/SERVER_NAME
docker compose pull && docker compose restart
```

### Backup & Files

```bash
# Quick backup
docker cp mc-SERVER_NAME:/data/worlds ./backup-$(date +%Y%m%d)/    # Bedrock
docker cp mc-SERVER_NAME:/data/world ./backup-$(date +%Y%m%d)/     # Java

# Add mods/plugins (Java only)
docker cp file.jar mc-SERVER_NAME:/data/mods/     # Forge/Fabric
docker cp file.jar mc-SERVER_NAME:/data/plugins/  # Paper/Spigot

# List installed
docker exec mc-SERVER_NAME ls /data/mods/
docker exec mc-SERVER_NAME ls /data/plugins/
```

## 📁 File Structure

```
/opt/minecraft-servers/
├── java-server1/
│   ├── docker-compose.yml    # Configuration
│   └── data/
│       ├── world/           # Java world
│       ├── mods/            # Mods (Forge/Fabric)
│       ├── plugins/         # Plugins (Paper/Spigot)
│       └── server.properties
└── bedrock-server1/
    ├── docker-compose.yml
    └── data/
        ├── worlds/          # Bedrock worlds
        └── server.properties
```

## 🔧 Quick Helper Script

Create a helper script for easier management:

```bash
cat > ~/mc.sh << 'EOF'
#!/bin/bash
SERVER=$1; ACTION=$2
case $ACTION in
    start)   cd /opt/minecraft-servers/$SERVER && docker compose up -d ;;
    stop)    cd /opt/minecraft-servers/$SERVER && docker compose down ;;
    restart) cd /opt/minecraft-servers/$SERVER && docker compose restart ;;
    logs)    cd /opt/minecraft-servers/$SERVER && docker compose logs -f ;;
    console) docker attach mc-$SERVER ;;
    status)  docker ps | grep mc-$SERVER ;;
    backup)  docker cp mc-$SERVER:/data/world* ./backup-$SERVER-$(date +%Y%m%d)/ ;;
    *) echo "Usage: $0 SERVER {start|stop|restart|logs|console|status|backup}" ;;
esac
EOF
chmod +x ~/mc.sh

# Usage: ~/mc.sh myserver start
```

## 🚨 Troubleshooting

| **Issue**            | **Solution**                           |
| -------------------- | -------------------------------------- |
| Server won't start   | `docker logs mc-SERVER_NAME`           |
| Port already in use  | Change port in docker-compose.yml      |
| Custom version fails | Verify version exists for your edition |
| Permission denied    | Run with `sudo`                        |
| Docker not found     | Choose "Full Installation"             |

## 📋 Reference

### Daily Commands

```bash
docker ps | grep mc-                   # List running servers
~/mc.sh SERVER_NAME logs              # View logs
~/mc.sh SERVER_NAME console           # Console access
~/mc.sh SERVER_NAME backup            # Quick backup
```

### Network Management

```bash
sudo ufw status                       # Check firewall
sudo ufw allow NEW_PORT/tcp           # Add Java port
sudo ufw allow NEW_PORT/udp           # Add Bedrock port
telnet SERVER_IP PORT                 # Test connectivity
```

### Edition-Specific Notes

**Java Edition:**

- Uses TCP connections
- Supports mods (Forge/Fabric) and plugins (Paper/Spigot)
- World folder: `/data/world`
- **Cracked Support**: Can enable offline mode for non-premium players

**Bedrock Edition:**

- Uses UDP connections
- Cross-platform compatible
- Worlds folder: `/data/worlds`
- **Premium Only**: Requires official Microsoft/Mojang accounts

### System Maintenance

```bash
docker system prune -a                # Clean unused resources
sudo systemctl restart docker         # Restart Docker service
free -h && df -h                      # Check system resources
```

---

<div align="center">

**[⬆ Back to Top](#-minecraft-server-auto-installer)**

Made with ❤️ for the Minecraft community

</div>
