<div align="center">

# 🎮 Minecraft Server Auto Installer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-18.04+-orange.svg)](https://ubuntu.com/)
[![Minecraft](https://img.shields.io/badge/Minecraft-1.16.5--Latest-green.svg)](https://minecraft.net/)

**Automated Minecraft server installer using Docker with support for multiple server types and cracked players**

[Quick Start](#-quick-start) • [Installation](#-installation) • [Features](#-features) • [Documentation](#-documentation)

</div>

---

## 🚀 Quick Start

Deploy your Minecraft server in **under 5 minutes** with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh | sudo bash
```

## 📋 System Requirements

| Component   | Minimum                    | Recommended       |
| ----------- | -------------------------- | ----------------- |
| **OS**      | Ubuntu 18.04+ / Debian 10+ | Ubuntu 20.04+     |
| **RAM**     | 2GB                        | 4GB+              |
| **Storage** | 10GB free space            | 20GB+             |
| **CPU**     | 2 cores                    | 4 cores+          |
| **Network** | Port 25565 open            | Stable connection |

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

- 🔄 **Fully Automated**: Zero manual configuration required
- 🐳 **Docker-based**: Containerized for better isolation and management
- 🌐 **Cracked Support**: Offline mode enabled for cracked clients
- ⚡ **Performance Optimized**: Aikar flags and memory optimization
- 🔒 **Security**: Automatic firewall configuration

### 🎮 Supported Server Types

| Type        | Description               | Best For                  |
| ----------- | ------------------------- | ------------------------- |
| **Vanilla** | Official Minecraft server | Pure Minecraft experience |
| **Paper**   | High-performance fork     | Large servers, plugins    |
| **Spigot**  | Popular plugin platform   | Custom plugins            |
| **Forge**   | Mod support platform      | Modded gameplay           |
| **Fabric**  | Lightweight mod loader    | Modern mods               |
| **Purpur**  | Enhanced Paper fork       | Advanced features         |
| **Mohist**  | Forge + Bukkit hybrid     | Mods + Plugins            |

### 🔧 Supported Versions

- **Latest** (Always up-to-date)
- **1.21.x** (Current)
- **1.20.x** (Stable)
- **1.19.x** (Legacy)
- **1.18.x** (Legacy)
- **1.16.5** (Popular)

## 📊 Server Configuration

```yaml
Default Settings:
├── Port: 25565 (TCP/UDP)
├── RCON: 25575 (enabled)
├── Max Players: 20
├── Memory: 2GB (limit: 3GB)
├── Difficulty: Normal
├── Online Mode: False (cracked)
├── Flight: Enabled
└── Spawn Protection: Disabled
```

## 🛠️ Server Management

### Basic Commands

```bash
# Check server status
docker ps

# View live logs
docker logs minecraft-server -f

# Server console (RCON)
docker exec -i minecraft-server rcon-cli
```

### Control Commands

```bash
# Stop server
cd /opt/minecraft-server && docker-compose down

# Start server
cd /opt/minecraft-server && docker-compose up -d

# Restart server
cd /opt/minecraft-server && docker-compose restart

# Update server
cd /opt/minecraft-server && docker-compose pull && docker-compose up -d
```

### Advanced Management

```bash
# Edit server configuration
sudo nano /opt/minecraft-server/docker-compose.yml

# Backup world data
docker cp minecraft-server:/data/world ./backup-$(date +%Y%m%d)/

# View resource usage
docker stats minecraft-server

# Scale memory (edit docker-compose.yml)
# MEMORY: "4G" for 4GB allocation
```

## 🔧 Configuration

### Memory Optimization

```yaml
# For 1GB RAM servers
MEMORY: "512M"

# For 2GB RAM servers (default)
MEMORY: "2G"

# For 4GB+ RAM servers
MEMORY: "3G"
```

### Custom Server Properties

```bash
# Access server files
cd /opt/minecraft-server
docker exec -it minecraft-server bash

# Edit server.properties
nano /data/server.properties
```

## 🔐 Security Best Practices

- ✅ **SSH Protection**: Automatic SSH access protection during firewall setup
- ✅ **UFW Firewall**: Auto-configured with secure defaults
- ✅ **Port Management**: Only necessary ports (22, 25565) are opened
- ✅ **Regular Backups**: Backup world data regularly
- ✅ **Log Monitoring**: Monitor server logs for suspicious activity
- ✅ **System Updates**: Keep Docker and system updated
- ⚠️ **Online Mode**: Consider enabling online-mode for production
- ⚠️ **Whitelist**: Use whitelist for private servers

### SSH Access Protection

The installer automatically protects your SSH access:

```bash
# SSH protection is built-in during installation
# These ports are automatically secured:
# - Port 22 (SSH) - ALWAYS PROTECTED
# - Port 25565 (Minecraft) - GAME ACCESS
# - Custom SSH ports are auto-detected

# Manual SSH protection (if needed)
sudo ufw allow ssh
sudo ufw allow 22/tcp

# Check firewall status
sudo ufw status numbered
```

### Firewall Management

```bash
# View current firewall rules
sudo ufw status verbose

# Add custom port (if needed)
sudo ufw allow [PORT]/tcp

# Remove rule
sudo ufw delete [RULE_NUMBER]

# Reset firewall (DANGER - may lock SSH)
sudo ufw --force reset
# Then re-run: sudo ufw allow ssh && sudo ufw enable
```

## 🔍 Troubleshooting

### Common Issues

<details>
<summary>🔒 SSH Access Issues</summary>

```bash
# If you're locked out of SSH (prevention method)
# The installer automatically protects SSH access
# But if issues occur:

# From local console/VNC:
sudo ufw allow ssh
sudo ufw allow 22/tcp
sudo ufw reload

# Check SSH service
sudo systemctl status ssh
sudo systemctl restart ssh

# Verify SSH is listening
sudo netstat -tlnp | grep :22
```

</details>

<details>
<summary>🚨 Port 25565 not accessible</summary>

```bash
# Check firewall status
sudo ufw status

# Open required ports (SSH is always protected first)
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
sudo ufw reload

# Check if service is running
docker ps | grep minecraft
```

</details>

<details>
<summary>💾 Memory/Performance Issues</summary>

```bash
# Check system resources
free -h
df -h

# Reduce memory allocation
cd /opt/minecraft-server
sudo nano docker-compose.yml
# Change MEMORY: "2G" to "1G"

# Restart with new settings
docker-compose restart
```

</details>

<details>
<summary>🔍 Server Won't Start</summary>

```bash
# Check detailed logs
docker logs minecraft-server --tail 100

# Check docker-compose status
cd /opt/minecraft-server
docker-compose logs

# Restart Docker service
sudo systemctl restart docker
```

</details>

<details>
<summary>🔄 Update/Migration Issues</summary>

```bash
# Backup before update
docker cp minecraft-server:/data ./backup-$(date +%Y%m%d)

# Clean update
cd /opt/minecraft-server
docker-compose down
docker-compose pull
docker-compose up -d
```

</details>

## 📁 File Structure

```
/opt/minecraft-server/
├── docker-compose.yml      # Main configuration
├── logs/                   # Server logs (if mounted)
└── minecraft-data/         # Docker volume (world data)
    ├── world/              # Main world
    ├── world_nether/       # Nether dimension
    ├── world_the_end/      # End dimension
    ├── server.properties   # Server configuration
    ├── ops.json           # Operator list
    ├── whitelist.json     # Whitelist (if enabled)
    └── banned-players.json # Banned players
```

## 📈 Performance Monitoring

```bash
# Real-time resource monitoring
docker stats minecraft-server

# Check server TPS (in-game)
/tps

# Memory usage details
docker exec minecraft-server free -h

# Disk usage
docker system df
```

## 🔐 Security Best Practices

- ✅ Use UFW firewall (auto-configured)
- ✅ Regular backups of world data
- ✅ Monitor server logs for suspicious activity
- ✅ Keep Docker and system updated
- ⚠️ Consider enabling online-mode for production
- ⚠️ Use whitelist for private servers

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [itzg/minecraft-server](https://github.com/itzg/docker-minecraft-server) for the excellent Docker image
- Minecraft community for server optimization guides
- Contributors and testers

## 📞 Support

- 📧 **Issues**: [GitHub Issues](https://github.com/MochNad/minecraft-server-installer/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/MochNad/minecraft-server-installer/discussions)
- 📚 **Wiki**: [Project Wiki](https://github.com/MochNad/minecraft-server-installer/wiki)

---

<div align="center">

**[⬆ Back to Top](#-minecraft-server-auto-installer)**

Made with ❤️ for the Minecraft community

</div>
