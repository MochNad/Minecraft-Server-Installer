<div align="center>

# 🎮 Minecraft Server Auto Installer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-18.04+-orange.svg)](https://ubuntu.com/)
[![Minecraft](https://img.shields.io/badge/Minecraft-Multiple%20Versions-green.svg)](https://minecraft.net/)

**Automated Minecraft server installer with Docker support for multiple versions, server types, and multi-server management**

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

### Configuration Options

```
🏷️  Server Name       → Custom naming for organization
🎯 Version           → 9 versions (latest to 1.16.5)
⚡ Type             → VANILLA/FORGE/FABRIC/PAPER/SPIGOT/PURPUR/MOHIST
🌐 Port             → Custom port (default: 25565)
🔓 Cracked Support   → Enable/disable offline mode
👥 Max Players       → 1-200 players
🎮 Game Mode        → Survival/Creative/Adventure/Spectator
💾 Memory           → 1GB-Custom allocation
```

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
docker attach minecraft-SERVER_NAME

# Status check
docker ps | grep minecraft
```

### Multi-Server Operations

```bash
# List servers
ls /opt/minecraft-servers/

# Start/stop all servers
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose up -d; done
for d in /opt/minecraft-servers/*/; do cd "$d" && docker compose down; done

# Check status
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep minecraft
```

### Monitoring & Maintenance

```bash
# Resource monitoring
docker stats minecraft-SERVER_NAME

# Error checking
docker logs minecraft-SERVER_NAME | grep -i "error\|exception"

# Live game mode change
docker exec minecraft-SERVER_NAME rcon-cli "defaultgamemode survival"

# Server updates
cd /opt/minecraft-servers/SERVER_NAME
docker compose pull && docker compose restart
```

### Backup & Files

```bash
# Quick backup
docker cp minecraft-SERVER_NAME:/data/world ./backup-$(date +%Y%m%d)/

# Add mods/plugins
docker cp file.jar minecraft-SERVER_NAME:/data/mods/     # Forge/Fabric
docker cp file.jar minecraft-SERVER_NAME:/data/plugins/ # Paper/Spigot

# List installed
docker exec minecraft-SERVER_NAME ls /data/mods/
docker exec minecraft-SERVER_NAME ls /data/plugins/
```

## 📁 File Structure

```
/opt/minecraft-servers/
├── server1/
│   ├── docker-compose.yml    # Configuration
│   └── data/
│       ├── world/           # Game world
│       ├── mods/            # Mods (Forge/Fabric)
│       ├── plugins/         # Plugins (Paper/Spigot)
│       └── server.properties
└── server2/
    └── ...
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
    console) docker attach minecraft-$SERVER ;;
    status)  docker ps | grep minecraft-$SERVER ;;
    backup)  docker cp minecraft-$SERVER:/data/world ./backup-$SERVER-$(date +%Y%m%d)/ ;;
    *) echo "Usage: $0 SERVER {start|stop|restart|logs|console|status|backup}" ;;
esac
EOF
chmod +x ~/mc.sh

# Usage: ~/mc.sh myserver start
```

## 🚨 Troubleshooting

| **Issue**           | **Solution**                        |
| ------------------- | ----------------------------------- |
| Server won't start  | `docker logs minecraft-SERVER_NAME` |
| Port already in use | Change port in docker-compose.yml   |
| Out of memory       | Increase memory allocation          |
| Permission denied   | Run with `sudo`                     |
| Docker not found    | Choose "Full Installation"          |

## 📋 Reference

### Daily Commands

```bash
docker ps | grep minecraft              # List running servers
~/mc.sh SERVER_NAME logs               # View logs
~/mc.sh SERVER_NAME console            # Console access
~/mc.sh SERVER_NAME backup             # Quick backup
```

### Network Management

```bash
sudo ufw status                        # Check firewall
sudo ufw allow NEW_PORT/tcp            # Add port
telnet SERVER_IP PORT                  # Test connectivity
```

### System Maintenance

```bash
docker system prune -a                 # Clean unused resources
sudo systemctl restart docker          # Restart Docker service
free -h && df -h                       # Check system resources
```

---

<div align="center">

**[⬆ Back to Top](#-minecraft-server-auto-installer)**

Made with ❤️ for the Minecraft community

</div>
