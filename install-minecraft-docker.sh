#!/bin/bash

# Colors for output - Enhanced with more vibrant colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
ORANGE='\033[0;33m'
PINK='\033[1;35m'
LIGHT_BLUE='\033[1;34m'
LIGHT_GREEN='\033[1;32m'
LIGHT_RED='\033[1;31m'
NC='\033[0m' # No Color

clear
echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${LIGHT_BLUE}║${WHITE}          🎮 Minecraft Server Auto Installer 🎮              ${LIGHT_BLUE}║${NC}"
echo -e "${LIGHT_BLUE}║${CYAN}                    with Docker Support                       ${LIGHT_BLUE}║${NC}"
echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo -e "${YELLOW}🚀 Starting installation process...${NC}"
sleep 2

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run this script as root (use sudo)${NC}"
        exit 1
    fi
}

# Set default configuration (no user input)
set_default_configuration() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              📋 Server Configuration 📋                      ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}🔧 Using optimized default configuration...${NC}"
    echo ""
    
    # Fixed configuration
    MC_VERSION="1.21.7"
    SERVER_TYPE="FORGE"
    SERVER_PORT="25565"
    ONLINE_MODE="FALSE"
    CRACKED_STATUS="ENABLED"
    MAX_PLAYERS="20"
    MEMORY="2G"
    MEMORY_LIMIT="3G"
    
    echo -e "${PINK}🎮 Minecraft Version:${NC} ${LIGHT_GREEN}$MC_VERSION${NC}"
    echo -e "${PINK}⚡ Server Type:${NC} ${LIGHT_GREEN}$SERVER_TYPE${NC} ${ORANGE}(Mod Support)${NC}"
    echo -e "${PINK}🌐 Server Port:${NC} ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${PINK}🔓 Cracked Support:${NC} ${LIGHT_GREEN}$CRACKED_STATUS${NC}"
    echo -e "${PINK}👥 Max Players:${NC} ${LIGHT_GREEN}$MAX_PLAYERS${NC}"
    echo -e "${PINK}💾 Memory Allocation:${NC} ${LIGHT_GREEN}$MEMORY${NC} ${ORANGE}(limit: $MEMORY_LIMIT)${NC}"
    echo ""
    echo -e "${LIGHT_GREEN}✅ Configuration ready! Starting installation...${NC}"
    sleep 3
}

# Update system
update_system() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              📦 Step 1: Updating System 📦                   ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🔄 Updating system packages...${NC}"
    apt update && apt upgrade -y
    apt install -y curl wget ufw
    echo -e "${LIGHT_GREEN}✅ System update completed!${NC}"
    sleep 2
}

# Install Docker and Docker Compose
install_docker() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              🐳 Step 2: Installing Docker 🐳                 ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}📥 Installing Docker and Docker Compose...${NC}"
    if ! command -v docker &> /dev/null; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        usermod -aG docker $SUDO_USER
        systemctl enable docker
        systemctl start docker
        rm get-docker.sh
        echo -e "${LIGHT_GREEN}✅ Docker installed successfully${NC}"
    else
        echo -e "${LIGHT_GREEN}✅ Docker already installed${NC}"
    fi
    
    # Install latest docker-compose
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${YELLOW}📥 Installing latest Docker Compose...${NC}"
        COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d'"' -f4)
        curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        echo -e "${LIGHT_GREEN}✅ Docker Compose $COMPOSE_VERSION installed successfully${NC}"
    else
        echo -e "${LIGHT_GREEN}✅ Docker Compose already installed${NC}"
        echo -e "${CYAN}📋 Current version: $(docker-compose --version)${NC}"
    fi
    echo -e "${LIGHT_GREEN}🎉 Docker installation completed!${NC}"
    sleep 2
}

# Configure firewall with custom port
configure_firewall() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}            🔒 Step 3: Configuring Firewall 🔒               ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🛡️  Configuring firewall with SSH protection...${NC}"
    
    # Enable SSH before any other rules to prevent lockout
    echo -e "${CYAN}🔐 Enabling SSH access protection...${NC}"
    ufw allow ssh
    ufw allow 22/tcp
    
    # Get current SSH port if different from 22
    SSH_PORT=$(ss -tlnp | grep sshd | awk '{print $4}' | cut -d':' -f2 | head -1)
    if [ ! -z "$SSH_PORT" ] && [ "$SSH_PORT" != "22" ]; then
        echo -e "${CYAN}🔍 Detected custom SSH port: ${LIGHT_GREEN}$SSH_PORT${NC}"
        ufw allow $SSH_PORT/tcp
    fi
    
    # Enable Minecraft ports
    echo -e "${CYAN}🎮 Enabling Minecraft server port: ${LIGHT_GREEN}$SERVER_PORT${NC}"
    ufw allow $SERVER_PORT/tcp
    ufw allow $SERVER_PORT/udp
    
    # Set default policies
    ufw --force default deny incoming
    ufw --force default allow outgoing
    
    # Enable firewall only if not already enabled
    if ! ufw status | grep -q "Status: active"; then
        echo -e "${YELLOW}🔥 Enabling firewall...${NC}"
        ufw --force enable
    fi
    
    echo -e "${LIGHT_GREEN}✅ SSH access: ${WHITE}PROTECTED${NC}"
    echo -e "${LIGHT_GREEN}✅ Port $SERVER_PORT: ${WHITE}ENABLED${NC}"
    echo -e "${LIGHT_GREEN}✅ Firewall: ${WHITE}ACTIVE${NC}"
    
    # Show current SSH connections for verification
    echo -e "${CYAN}🔗 Current SSH connections:${NC}"
    who | grep pts
    
    echo -e "${LIGHT_GREEN}🎉 Firewall configuration completed safely!${NC}"
    sleep 3
}

# Setup Minecraft server
setup_minecraft_server() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}        🔧 Step 4: Setting Up Server Configuration 🔧        ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🎮 Setting up Minecraft Forge 1.21.7 server...${NC}"
    
    mkdir -p /opt/minecraft-server
    cd /opt/minecraft-server
    
    # Create docker-compose.yml with fixed configuration
    cat > docker-compose.yml << EOF
version: '3.9'

services:
  minecraft:
    image: itzg/minecraft-server:latest
    container_name: minecraft-server
    ports:
      - "$SERVER_PORT:25565"
    environment:
      EULA: "TRUE"
      VERSION: "$MC_VERSION"
      TYPE: "$SERVER_TYPE"
      ONLINE_MODE: "$ONLINE_MODE"
      DIFFICULTY: "normal"
      MAX_PLAYERS: "$MAX_PLAYERS"
      MOTD: "Welcome to Forge 1.21.7 Server - Mods Supported!"
      ALLOW_FLIGHT: "TRUE"
      SPAWN_PROTECTION: "0"
      MEMORY: "$MEMORY"
      USE_AIKAR_FLAGS: "TRUE"
      ENABLE_RCON: "TRUE"
      RCON_PORT: "25575"
      RCON_PASSWORD: ""
      # Forge specific settings
      FORGE_VERSION: "RECOMMENDED"
      REMOVE_OLD_MODS: "TRUE"
      MODS_FILE: ""
    volumes:
      - minecraft-data:/data
    restart: unless-stopped
    stdin_open: true
    tty: true
    deploy:
      resources:
        limits:
          memory: $MEMORY_LIMIT
        reservations:
          memory: $MEMORY

volumes:
  minecraft-data:
    driver: local
EOF

    echo -e "${LIGHT_GREEN}✅ Forge server configuration created${NC}"
    echo -e "${LIGHT_GREEN}✅ Server configuration completed!${NC}"
    sleep 2
}

# Enhanced start_server function
start_server() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}           🚀 Step 5: Starting Minecraft Server 🚀            ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🎮 Starting Forge 1.21.7 server...${NC}"
    cd /opt/minecraft-server
    
    # Pull the latest image
    echo -e "${CYAN}📥 Pulling latest Docker image...${NC}"
    docker-compose pull
    
    # Start the server
    echo -e "${CYAN}🚀 Starting Forge server container...${NC}"
    docker-compose up -d
    
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}         🎉 Forge Server Installation Complete! 🎉            ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${PINK}📊 Server details:${NC}"
    echo -e "${CYAN}  • Version:${NC} ${LIGHT_GREEN}Minecraft $MC_VERSION${NC}"
    echo -e "${CYAN}  • Type:${NC} ${LIGHT_GREEN}$SERVER_TYPE${NC} ${ORANGE}(Mod Support Enabled)${NC}"
    echo -e "${CYAN}  • Port:${NC} ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${CYAN}  • RCON Port:${NC} ${LIGHT_GREEN}25575${NC} ${ORANGE}(no password)${NC}"
    echo -e "${CYAN}  • Cracked players:${NC} ${LIGHT_GREEN}$CRACKED_STATUS${NC}"
    echo -e "${CYAN}  • Max players:${NC} ${LIGHT_GREEN}$MAX_PLAYERS${NC}"
    echo -e "${CYAN}  • Memory:${NC} ${LIGHT_GREEN}$MEMORY${NC} ${ORANGE}(limit: $MEMORY_LIMIT)${NC}"
    echo -e "${CYAN}  • Aikar Flags:${NC} ${LIGHT_GREEN}ENABLED${NC}"
    echo -e "${CYAN}  • Forge Version:${NC} ${LIGHT_GREEN}RECOMMENDED${NC}"
    echo ""
    echo -e "${PINK}🔒 Security Status:${NC}"
    echo -e "${CYAN}  • SSH Access:${NC} ${LIGHT_GREEN}PROTECTED${NC}"
    echo -e "${CYAN}  • Firewall:${NC} ${LIGHT_GREEN}ACTIVE${NC}"
    echo -e "${CYAN}  • Open ports:${NC} ${LIGHT_GREEN}22 (SSH)${NC} ${WHITE}and${NC} ${LIGHT_GREEN}$SERVER_PORT (Minecraft)${NC}"
    echo ""
    echo -e "${PINK}⚡ Useful commands:${NC}"
    echo -e "${CYAN}  • Check logs:${NC} ${LIGHT_BLUE}docker logs minecraft-server -f${NC}"
    echo -e "${CYAN}  • Stop server:${NC} ${LIGHT_BLUE}cd /opt/minecraft-server && docker-compose down${NC}"
    echo -e "${CYAN}  • Restart server:${NC} ${LIGHT_BLUE}cd /opt/minecraft-server && docker-compose restart${NC}"
    echo -e "${CYAN}  • Server console:${NC} ${LIGHT_BLUE}docker exec -i minecraft-server rcon-cli${NC}"
    echo -e "${CYAN}  • Add mods folder:${NC} ${LIGHT_BLUE}docker exec minecraft-server ls /data/mods${NC}"
    echo ""
    echo -e "${PINK}🔧 Mod Management:${NC}"
    echo -e "${CYAN}  • Mods folder:${NC} ${LIGHT_BLUE}/opt/minecraft-server/mods${NC}"
    echo -e "${CYAN}  • Upload mods:${NC} ${LIGHT_BLUE}docker cp mod.jar minecraft-server:/data/mods/${NC}"
    echo -e "${CYAN}  • Restart after adding mods:${NC} ${LIGHT_BLUE}docker-compose restart${NC}"
    echo ""
    echo -e "${LIGHT_GREEN}🎉 Forge 1.21.7 server ready! First startup may take 5-10 minutes.${NC}"
    echo -e "${YELLOW}🌐 Connect using: ${LIGHT_GREEN}YOUR_SERVER_IP:$SERVER_PORT${NC}"
    echo -e "${CYAN}⏱️  Forge will download and install automatically on first run${NC}"
    echo -e "${ORANGE}🔧 You can add mods to the /data/mods folder after startup${NC}"
    echo ""
    echo -e "${LIGHT_RED}⚠️  IMPORTANT: Your SSH access is protected and will remain available${NC}"
}

# Main execution
main() {
    check_root
    set_default_configuration
    update_system
    install_docker
    configure_firewall
    setup_minecraft_server
    start_server
}

# Run main function
main