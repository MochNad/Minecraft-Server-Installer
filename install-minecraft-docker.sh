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
echo -e "${YELLOW}🚀 Starting configuration process...${NC}"
sleep 2

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run this script as root (use sudo)${NC}"
        exit 1
    fi
}

# Get all server configuration from user first
get_server_configuration() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              ⚙️  Server Configuration Setup ⚙️               ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}📝 Please configure your Minecraft server settings${NC}"
    echo ""
    
    # Get Minecraft version
    echo -e "${PINK}🎯 Available Minecraft versions:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}latest${NC} ${ORANGE}(newest stable)${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}1.21.81${NC} ${ORANGE}(latest bedrock compatible)${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}1.21.7${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}1.21.4${NC}"
    echo -e "${LIGHT_GREEN}5.${NC} ${WHITE}1.21.1${NC}"
    echo -e "${LIGHT_GREEN}6.${NC} ${WHITE}1.20.4${NC}"
    echo -e "${LIGHT_GREEN}7.${NC} ${WHITE}1.19.4${NC}"
    echo -e "${LIGHT_GREEN}8.${NC} ${WHITE}1.18.2${NC}"
    echo -e "${LIGHT_GREEN}9.${NC} ${WHITE}1.16.5${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🎮 Select Minecraft version (${YELLOW}1-9${CYAN}): ${NC}"
        read VERSION_CHOICE
        
        if [[ "$VERSION_CHOICE" == "1" ]]; then
            MC_VERSION="latest"
            break
        elif [[ "$VERSION_CHOICE" == "2" ]]; then
            MC_VERSION="1.21.81"
            break
        elif [[ "$VERSION_CHOICE" == "3" ]]; then
            MC_VERSION="1.21.7"
            break
        elif [[ "$VERSION_CHOICE" == "4" ]]; then
            MC_VERSION="1.21.4"
            break
        elif [[ "$VERSION_CHOICE" == "5" ]]; then
            MC_VERSION="1.21.1"
            break
        elif [[ "$VERSION_CHOICE" == "6" ]]; then
            MC_VERSION="1.20.4"
            break
        elif [[ "$VERSION_CHOICE" == "7" ]]; then
            MC_VERSION="1.19.4"
            break
        elif [[ "$VERSION_CHOICE" == "8" ]]; then
            MC_VERSION="1.18.2"
            break
        elif [[ "$VERSION_CHOICE" == "9" ]]; then
            MC_VERSION="1.16.5"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a number between 1-9${NC}"
            continue
        fi
    done
    
    echo ""
    # Get server type
    echo -e "${PINK}🔧 Available server types:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}VANILLA${NC} ${ORANGE}(Default Minecraft)${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}FORGE${NC} ${ORANGE}(Mod support)${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}FABRIC${NC} ${ORANGE}(Lightweight mod support)${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}PAPER${NC} ${ORANGE}(Performance optimized)${NC}"
    echo -e "${LIGHT_GREEN}5.${NC} ${WHITE}SPIGOT${NC} ${ORANGE}(Plugin support)${NC}"
    echo -e "${LIGHT_GREEN}6.${NC} ${WHITE}PURPUR${NC} ${ORANGE}(Enhanced Paper)${NC}"
    echo -e "${LIGHT_GREEN}7.${NC} ${WHITE}MOHIST${NC} ${ORANGE}(Forge + Bukkit plugins)${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}⚡ Select server type (${YELLOW}1-7${CYAN}): ${NC}"
        read SERVER_CHOICE
        
        if [[ "$SERVER_CHOICE" == "1" ]]; then
            SERVER_TYPE="VANILLA"
            break
        elif [[ "$SERVER_CHOICE" == "2" ]]; then
            SERVER_TYPE="FORGE"
            break
        elif [[ "$SERVER_CHOICE" == "3" ]]; then
            SERVER_TYPE="FABRIC"
            break
        elif [[ "$SERVER_CHOICE" == "4" ]]; then
            SERVER_TYPE="PAPER"
            break
        elif [[ "$SERVER_CHOICE" == "5" ]]; then
            SERVER_TYPE="SPIGOT"
            break
        elif [[ "$SERVER_CHOICE" == "6" ]]; then
            SERVER_TYPE="PURPUR"
            break
        elif [[ "$SERVER_CHOICE" == "7" ]]; then
            SERVER_TYPE="MOHIST"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a number between 1-7${NC}"
            continue
        fi
    done
    
    echo ""
    # Get server port
    while true; do
        echo -ne "${CYAN}🌐 Enter server port (${YELLOW}default 25565${CYAN}): ${NC}"
        read SERVER_PORT
        if [ -z "$SERVER_PORT" ]; then
            SERVER_PORT="25565"
            break
        elif [[ "$SERVER_PORT" =~ ^[0-9]+$ ]] && [ "$SERVER_PORT" -ge 1024 ] && [ "$SERVER_PORT" -le 65535 ]; then
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a valid port number (1024-65535)${NC}"
        fi
    done
    
    echo ""
    # Get cracked support
    while true; do
        echo -ne "${CYAN}🔓 Enable cracked players support? (${YELLOW}y/n, default y${CYAN}): ${NC}"
        read CRACKED_CHOICE
        if [ -z "$CRACKED_CHOICE" ] || [[ "$CRACKED_CHOICE" =~ ^[Yy]$ ]]; then
            ONLINE_MODE="FALSE"
            CRACKED_STATUS="ENABLED"
            break
        elif [[ "$CRACKED_CHOICE" =~ ^[Nn]$ ]]; then
            ONLINE_MODE="TRUE"
            CRACKED_STATUS="DISABLED"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter y or n${NC}"
        fi
    done
    
    echo ""
    # Get max players
    while true; do
        echo -ne "${CYAN}👥 Maximum players (${YELLOW}default 20${CYAN}): ${NC}"
        read MAX_PLAYERS
        if [ -z "$MAX_PLAYERS" ]; then
            MAX_PLAYERS="20"
            break
        elif [[ "$MAX_PLAYERS" =~ ^[0-9]+$ ]] && [ "$MAX_PLAYERS" -ge 1 ] && [ "$MAX_PLAYERS" -le 200 ]; then
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a number between 1-200${NC}"
        fi
    done
    
    echo ""
    # Get memory allocation
    echo -e "${PINK}💾 Available memory options:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}1GB${NC} ${ORANGE}(for low-end VPS)${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}2GB${NC} ${ORANGE}(recommended minimum)${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}3GB${NC} ${ORANGE}(good performance)${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}4GB${NC} ${ORANGE}(high performance)${NC}"
    echo -e "${LIGHT_GREEN}5.${NC} ${WHITE}Custom amount${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🔋 Select memory allocation (${YELLOW}1-5${CYAN}): ${NC}"
        read MEMORY_CHOICE
        
        if [[ "$MEMORY_CHOICE" == "1" ]]; then
            MEMORY="1G"
            MEMORY_LIMIT="1536M"
            break
        elif [[ "$MEMORY_CHOICE" == "2" ]]; then
            MEMORY="2G"
            MEMORY_LIMIT="3G"
            break
        elif [[ "$MEMORY_CHOICE" == "3" ]]; then
            MEMORY="3G"
            MEMORY_LIMIT="4G"
            break
        elif [[ "$MEMORY_CHOICE" == "4" ]]; then
            MEMORY="4G"
            MEMORY_LIMIT="5G"
            break
        elif [[ "$MEMORY_CHOICE" == "5" ]]; then
            while true; do
                echo -ne "${CYAN}💾 Enter custom memory (${YELLOW}e.g., 512M, 1G, 2G${CYAN}): ${NC}"
                read CUSTOM_MEMORY
                if [[ "$CUSTOM_MEMORY" =~ ^[0-9]+[MmGg]$ ]]; then
                    MEMORY="$CUSTOM_MEMORY"
                    # Calculate limit (add 1G for buffer)
                    if [[ "$CUSTOM_MEMORY" =~ ^[0-9]+[Mm]$ ]]; then
                        NUM=$(echo "$CUSTOM_MEMORY" | sed 's/[Mm]//')
                        MEMORY_LIMIT="$((NUM + 512))M"
                    else
                        NUM=$(echo "$CUSTOM_MEMORY" | sed 's/[Gg]//')
                        MEMORY_LIMIT="$((NUM + 1))G"
                    fi
                    break
                else
                    echo -e "${LIGHT_RED}❌ Please enter a valid memory format (e.g., 512M, 2G)${NC}"
                fi
            done
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a number between 1-5${NC}"
            continue
        fi
    done
    
    # Show configuration summary
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              📋 Configuration Summary 📋                      ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${PINK}🎮 Minecraft Version:${NC} ${LIGHT_GREEN}$MC_VERSION${NC}"
    echo -e "${PINK}⚡ Server Type:${NC} ${LIGHT_GREEN}$SERVER_TYPE${NC}"
    echo -e "${PINK}🌐 Server Port:${NC} ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${PINK}🔓 Cracked Support:${NC} ${LIGHT_GREEN}$CRACKED_STATUS${NC}"
    echo -e "${PINK}👥 Max Players:${NC} ${LIGHT_GREEN}$MAX_PLAYERS${NC}"
    echo -e "${PINK}💾 Memory Allocation:${NC} ${LIGHT_GREEN}$MEMORY${NC} ${ORANGE}(limit: $MEMORY_LIMIT)${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}✅ Confirm configuration and start installation? (${YELLOW}y/n${CYAN}): ${NC}"
        read CONFIRM
        if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
            echo -e "${LIGHT_GREEN}🚀 Starting installation with your configuration...${NC}"
            sleep 2
            break
        elif [[ "$CONFIRM" =~ ^[Nn]$ ]]; then
            echo -e "${YELLOW}❌ Installation cancelled. Run the script again to reconfigure.${NC}"
            exit 0
        else
            echo -e "${LIGHT_RED}❌ Please enter y or n${NC}"
        fi
    done
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

# Remove individual get functions and use setup directly
setup_minecraft_server() {
    clear
    echo -e "${BLUE}=== Step 4: Setting Up Server Configuration ===${NC}"
    echo -e "${YELLOW}Setting up Minecraft server with your configuration...${NC}"
    
    mkdir -p /opt/minecraft-server
    cd /opt/minecraft-server
    
    # Create docker-compose.yml with user configuration
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
      MOTD: "Welcome to $SERVER_TYPE Server v$MC_VERSION - Port $SERVER_PORT"
      ALLOW_FLIGHT: "TRUE"
      SPAWN_PROTECTION: "0"
      MEMORY: "$MEMORY"
      USE_AIKAR_FLAGS: "TRUE"
      ENABLE_RCON: "TRUE"
      RCON_PORT: "25575"
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

    echo -e "${GREEN}Docker configuration created${NC}"
    echo -e "${GREEN}Server configuration completed!${NC}"
    sleep 2
}

# Enhanced start_server function
start_server() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}           🚀 Step 5: Starting Minecraft Server 🚀            ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🎮 Starting Minecraft server...${NC}"
    cd /opt/minecraft-server
    
    # Pull the latest image
    docker-compose pull
    
    # Start the server
    docker-compose up -d
    
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}         🎉 Installation Completed Successfully! 🎉           ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${PINK}📊 Server details:${NC}"
    echo -e "${CYAN}  • Version:${NC} ${LIGHT_GREEN}$MC_VERSION${NC}"
    echo -e "${CYAN}  • Type:${NC} ${LIGHT_GREEN}$SERVER_TYPE${NC}"
    echo -e "${CYAN}  • Port:${NC} ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${CYAN}  • RCON Port:${NC} ${LIGHT_GREEN}25575${NC} ${ORANGE}(no password)${NC}"
    echo -e "${CYAN}  • Cracked players:${NC} ${LIGHT_GREEN}$CRACKED_STATUS${NC}"
    echo -e "${CYAN}  • Max players:${NC} ${LIGHT_GREEN}$MAX_PLAYERS${NC}"
    echo -e "${CYAN}  • Memory:${NC} ${LIGHT_GREEN}$MEMORY${NC} ${ORANGE}(limit: $MEMORY_LIMIT)${NC}"
    echo -e "${CYAN}  • Aikar Flags:${NC} ${LIGHT_GREEN}ENABLED${NC}"
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
    echo -e "${CYAN}  • Firewall status:${NC} ${LIGHT_BLUE}sudo ufw status${NC}"
    echo ""
    echo -e "${LIGHT_GREEN}🎉 Installation completed! Server will be ready in a few minutes.${NC}"
    echo -e "${YELLOW}🌐 You can connect using your server's IP address on port ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${CYAN}⏱️  First startup may take longer for $SERVER_TYPE server type${NC}"
    echo ""
    echo -e "${LIGHT_RED}⚠️  IMPORTANT: Your SSH access is protected and will remain available${NC}"
}

# Main execution
main() {
    check_root
    get_server_configuration
    update_system
    install_docker
    configure_firewall
    setup_minecraft_server
    start_server
}

# Run main function
main
