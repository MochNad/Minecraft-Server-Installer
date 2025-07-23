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
echo -e "${LIGHT_BLUE}║${WHITE}           🎮 Minecraft Server Auto Installer 🎮             ${LIGHT_BLUE}║${NC}"
echo -e "${LIGHT_BLUE}║${CYAN}                     with Docker Support                     ${LIGHT_BLUE}║${NC}"
echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo -e "${YELLOW}🚀 Starting configuration process...${NC}"
sleep 2

# Function to show main menu
show_main_menu() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}               🎯 Installation Type Selection 🎯              ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}📋 Please select your installation type:${NC}"
    echo ""
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}Full Installation${NC} ${ORANGE}(System update + Docker + Firewall + Server)${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}Add New Server Only${NC} ${ORANGE}(Requires Docker already installed)${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🔧 Select installation type (1-2): ${NC}"
        read INSTALL_CHOICE
        
        INSTALL_CHOICE=$(echo "$INSTALL_CHOICE" | tr -d '[:space:]')
        
        case "$INSTALL_CHOICE" in
            1) INSTALL_TYPE="FULL" echo -e "${LIGHT_GREEN}✅ Selected: Full Installation${NC}" break ;;
            2) INSTALL_TYPE="SERVER_ONLY" echo -e "${LIGHT_GREEN}✅ Selected: Add New Server Only${NC}" break ;;
            *) 
                echo -e "${LIGHT_RED}❌ Please enter 1 or 2${NC}" 
                ;;
        esac
    done
    
    sleep 2
}

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
    echo -e "${LIGHT_BLUE}║${WHITE}               ⚙️  Server Configuration Setup ⚙️              ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}📝 Please configure your Minecraft server settings${NC}"
    echo ""
    
    # Get server name
    while true; do
        echo -ne "${CYAN}🏷️  Enter server name (no spaces, use - or _): ${NC}"
        read SERVER_NAME
        
        SERVER_NAME=$(echo "$SERVER_NAME" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [[ "$SERVER_NAME" =~ ^[a-z0-9_-]+$ ]] && [ ${#SERVER_NAME} -ge 3 ] && [ ${#SERVER_NAME} -le 30 ]; then
            echo -e "${LIGHT_GREEN}✅ Server name: $SERVER_NAME${NC}"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a valid name (3-30 characters, only letters, numbers, - and _)${NC}"
        fi
    done
    
    echo ""
    sleep 1
    
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
        echo -ne "${CYAN}🎮 Select Minecraft version (1-9): ${NC}"
        read VERSION_CHOICE
        
        VERSION_CHOICE=$(echo "$VERSION_CHOICE" | tr -d '[:space:]')
        
        case "$VERSION_CHOICE" in
            1) MC_VERSION="latest"; break ;;
            2) MC_VERSION="1.21.81"; break ;;
            3) MC_VERSION="1.21.7"; break ;;
            4) MC_VERSION="1.21.4"; break ;;
            5) MC_VERSION="1.21.1"; break ;;
            6) MC_VERSION="1.20.4"; break ;;
            7) MC_VERSION="1.19.4"; break ;;
            8) MC_VERSION="1.18.2"; break ;;
            9) MC_VERSION="1.16.5"; break ;;
            *) echo -e "${LIGHT_RED}❌ Invalid input. Please enter a number between 1-9${NC}" ;;
        esac
    done
    echo -e "${LIGHT_GREEN}✅ Selected: $MC_VERSION${NC}"
    
    echo ""
    sleep 1
    
    # Get server type
    echo -e "${PINK}🔧 Available server types:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}VANILLA${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}FORGE${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}FABRIC${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}PAPER${NC}"
    echo -e "${LIGHT_GREEN}5.${NC} ${WHITE}SPIGOT${NC}"
    echo -e "${LIGHT_GREEN}6.${NC} ${WHITE}PURPUR${NC}"
    echo -e "${LIGHT_GREEN}7.${NC} ${WHITE}MOHIST${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}⚡ Select server type (1-7): ${NC}"
        read SERVER_CHOICE
        
        SERVER_CHOICE=$(echo "$SERVER_CHOICE" | tr -d '[:space:]')
        
        case "$SERVER_CHOICE" in
            1) SERVER_TYPE="VANILLA"; break ;;
            2) SERVER_TYPE="FORGE"; break ;;
            3) SERVER_TYPE="FABRIC"; break ;;
            4) SERVER_TYPE="PAPER"; break ;;
            5) SERVER_TYPE="SPIGOT"; break ;;
            6) SERVER_TYPE="PURPUR"; break ;;
            7) SERVER_TYPE="MOHIST"; break ;;
            *) echo -e "${LIGHT_RED}❌ Please enter a number between 1-7${NC}" ;;
        esac
    done
    echo -e "${LIGHT_GREEN}✅ Selected: $SERVER_TYPE${NC}"

    echo ""
    sleep 1
    
    # Get server port
    while true; do
        echo -ne "${CYAN}🌐 Enter server port (default 25565): ${NC}"
        read SERVER_PORT

        SERVER_PORT=${SERVER_PORT:-25565}
        
        if [[ "$SERVER_PORT" =~ ^[0-9]+$ ]] && [ "$SERVER_PORT" -ge 1024 ] && [ "$SERVER_PORT" -le 65535 ]; then
            echo -e "${LIGHT_GREEN}✅ Port set to: $SERVER_PORT${NC}"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a valid port number (1024-65535)${NC}"
        fi
    done
    
    echo ""
    sleep 1
    
    # Get cracked support
    while true; do
        echo -ne "${CYAN}🔓 Enable cracked players support? (y/n, default y): ${NC}"
        read CRACKED_CHOICE
        
        CRACKED_CHOICE=$(echo "${CRACKED_CHOICE:-y}" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [[ "$CRACKED_CHOICE" == "y" || "$CRACKED_CHOICE" == "yes" ]]; then
            ONLINE_MODE="FALSE"
            CRACKED_STATUS="ENABLED"
            echo -e "${LIGHT_GREEN}✅ Cracked players: ENABLED${NC}"
            break
        elif [[ "$CRACKED_CHOICE" == "n" || "$CRACKED_CHOICE" == "no" ]]; then
            ONLINE_MODE="TRUE"
            CRACKED_STATUS="DISABLED"
            echo -e "${LIGHT_GREEN}✅ Cracked players: DISABLED${NC}"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter y or n${NC}"
        fi
    done
    
    echo ""
    sleep 1
    
    # Get max players
    while true; do
        echo -ne "${CYAN}👥 Maximum players (default 20): ${NC}"
        read MAX_PLAYERS

        MAX_PLAYERS=${MAX_PLAYERS:-20}
        
        if [[ "$MAX_PLAYERS" =~ ^[0-9]+$ ]] && [ "$MAX_PLAYERS" -ge 1 ] && [ "$MAX_PLAYERS" -le 200 ]; then
            echo -e "${LIGHT_GREEN}✅ Max players: $MAX_PLAYERS${NC}"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a number between 1-200${NC}"
        fi
    done
    
    echo ""
    sleep 1
    
    # Get game mode
    echo -e "${PINK}🎮 Available game modes:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}Survival${NC} ${ORANGE}(gather resources, build, survive)${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}Creative${NC} ${ORANGE}(unlimited resources, flying)${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}Adventure${NC} ${ORANGE}(custom maps, limited interaction)${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}Spectator${NC} ${ORANGE}(observe only, no interaction)${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🎯 Select game mode (1-4, default 1): ${NC}"
        read GAMEMODE_CHOICE
        
        GAMEMODE_CHOICE=${GAMEMODE_CHOICE:-1}
        GAMEMODE_CHOICE=$(echo "$GAMEMODE_CHOICE" | tr -d '[:space:]')
        
        case "$GAMEMODE_CHOICE" in
            1) GAMEMODE="survival"; GAMEMODE_NAME="Survival"; break ;;
            2) GAMEMODE="creative"; GAMEMODE_NAME="Creative"; break ;;
            3) GAMEMODE="adventure"; GAMEMODE_NAME="Adventure"; break ;;
            4) GAMEMODE="spectator"; GAMEMODE_NAME="Spectator"; break ;;
            *) echo -e "${LIGHT_RED}❌ Please enter a number between 1-4${NC}" ;;
        esac
    done
    echo -e "${LIGHT_GREEN}✅ Game mode: $GAMEMODE_NAME${NC}"
    
    echo ""
    sleep 1
    
    # Get memory allocation
    echo -e "${PINK}💾 Available memory options:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}1GB${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}2GB${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}3GB${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}4GB${NC}"
    echo -e "${LIGHT_GREEN}5.${NC} ${WHITE}Custom amount${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🔋 Select memory allocation (1-5): ${NC}"
        read MEMORY_CHOICE
        
        MEMORY_CHOICE=$(echo "$MEMORY_CHOICE" | tr -d '[:space:]')
        
        case "$MEMORY_CHOICE" in
            1) MEMORY="1G"; MEMORY_LIMIT="1536M"; break ;;
            2) MEMORY="2G"; MEMORY_LIMIT="3G"; break ;;
            3) MEMORY="3G"; MEMORY_LIMIT="4G"; break ;;
            4) MEMORY="4G"; MEMORY_LIMIT="5G"; break ;;
            5)
                while true; do
                    echo -ne "${CYAN}💾 Enter custom memory (e.g., 512M, 2G): ${NC}"
                    read CUSTOM_MEMORY
                    
                    CUSTOM_MEMORY=$(echo "$CUSTOM_MEMORY" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
                    
                    if [[ "$CUSTOM_MEMORY" =~ ^[0-9]+[MG]$ ]]; then
                        MEMORY="$CUSTOM_MEMORY"
                        if [[ "$CUSTOM_MEMORY" =~ M$ ]]; then
                            NUM=${CUSTOM_MEMORY%M}
                            MEMORY_LIMIT="$((NUM + 512))M"
                        else
                            NUM=${CUSTOM_MEMORY%G}
                            MEMORY_LIMIT="$((NUM + 1))G"
                        fi
                        break
                    else
                        echo -e "${LIGHT_RED}❌ Please enter a valid memory format (e.g., 512M, 2G)${NC}"
                    fi
                done
                break
                ;;
            *) echo -e "${LIGHT_RED}❌ Please enter a number between 1-5${NC}" ;;
        esac
    done
    echo -e "${LIGHT_GREEN}✅ Memory: $MEMORY${NC}"

    # Show configuration summary
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}                 📋 Configuration Summary 📋                 ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${PINK}🏷️  Server Name:${NC} ${LIGHT_GREEN}$SERVER_NAME${NC}"
    echo -e "${PINK}🎮 Minecraft Version:${NC} ${LIGHT_GREEN}$MC_VERSION${NC}"
    echo -e "${PINK}⚡ Server Type:${NC} ${LIGHT_GREEN}$SERVER_TYPE${NC}"
    echo -e "${PINK}🌐 Server Port:${NC} ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${PINK}🔓 Cracked Support:${NC} ${LIGHT_GREEN}$CRACKED_STATUS${NC}"
    echo -e "${PINK}👥 Max Players:${NC} ${LIGHT_GREEN}$MAX_PLAYERS${NC}"
    echo -e "${PINK}🎯 Game Mode:${NC} ${LIGHT_GREEN}$GAMEMODE_NAME${NC}"
    echo -e "${PINK}💾 Memory Allocation:${NC} ${LIGHT_GREEN}$MEMORY${NC} ${ORANGE}(limit: $MEMORY_LIMIT)${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}✅ Confirm configuration and start installation? (${YELLOW}y/n${CYAN}): ${NC}"
        read CONFIRM
        
        CONFIRM=$(echo "$CONFIRM" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [[ "$CONFIRM" == "y" || "$CONFIRM" == "yes" ]]; then
            echo -e "${LIGHT_GREEN}🚀 Starting installation with your configuration...${NC}"
            sleep 2
            break
        elif [[ "$CONFIRM" == "n" || "$CONFIRM" == "no" ]]; then
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
    echo -e "${LIGHT_BLUE}║${WHITE}                 📦 Step 1: Updating System 📦                 ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🔄 Updating system packages...${NC}"
    apt-get update && apt-get upgrade -y
    echo -e "${LIGHT_GREEN}✅ System update completed!${NC}"
    sleep 2
}

# Install Docker and Docker Compose using official repository
install_docker() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}                🐳 Step 2: Installing Docker 🐳                ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}📥 Installing Docker and Docker Compose...${NC}"

    if ! command -v docker &> /dev/null; then
        echo -e "${CYAN}Docker not found. Installing using official repository method...${NC}"
        
        # 1. Install prerequisites
        apt-get install -y ca-certificates curl
        
        # 2. Add Docker's official GPG key
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        chmod a+r /etc/apt/keyrings/docker.asc
        
        # 3. Add the repository to Apt sources
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
          tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        
        # 4. Install Docker Engine, CLI, Containerd, and Compose plugin
        echo -e "${CYAN}Installing Docker packages...${NC}"
        apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        
        # 5. Post-installation steps
        echo -e "${CYAN}Configuring Docker user group...${NC}"
        if [ -n "$SUDO_USER" ]; then
            usermod -aG docker "$SUDO_USER"
            echo -e "${LIGHT_GREEN}✅ User '$SUDO_USER' added to the docker group.${NC}"
            echo -e "${YELLOW}💡 You may need to log out and log back in for this to take effect.${NC}"
        fi
        
        systemctl enable docker
        systemctl start docker
        echo -e "${LIGHT_GREEN}✅ Docker installed and started successfully.${NC}"
    else
        echo -e "${LIGHT_GREEN}✅ Docker is already installed.${NC}"
    fi

    # Verify Docker Compose plugin installation
    if docker compose version &> /dev/null; then
        echo -e "${LIGHT_GREEN}✅ Docker Compose plugin is installed.${NC}"
    else
        echo -e "${LIGHT_RED}❌ Docker Compose plugin not found. Please check the installation.${NC}"
    fi

    echo -e "${LIGHT_GREEN}🎉 Docker setup completed!${NC}"
    sleep 2
}


# Configure firewall with custom port
configure_firewall() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}               🔒 Step 3: Configuring Firewall 🔒              ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    
    if ! command -v ufw &> /dev/null; then
        echo -e "${YELLOW}🛡️  UFW not found. Installing...${NC}"
        apt-get install -y ufw
    fi

    echo -e "${YELLOW}🛡️  Configuring firewall with SSH protection...${NC}"
    
    ufw allow ssh
    ufw allow 22/tcp
    
    echo -e "${CYAN}🎮 Enabling Minecraft server port: ${LIGHT_GREEN}$SERVER_PORT${NC}"
    ufw allow "$SERVER_PORT/tcp"
    ufw allow "$SERVER_PORT/udp"
    
    ufw --force default deny incoming
    ufw --force default allow outgoing
    
    if ! ufw status | grep -q "Status: active"; then
        echo -e "${YELLOW}🔥 Enabling firewall...${NC}"
        ufw --force enable
    fi
    
    echo -e "${LIGHT_GREEN}✅ Firewall is active and configured.${NC}"
    sleep 3
}

# Setup Minecraft server
setup_minecraft_server() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}          🔧 Step 4: Setting Up Server Configuration 🔧          ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🎮 Setting up Minecraft server with your configuration...${NC}"
    
    # Create server-specific directory
    SERVER_DIR="/opt/minecraft-servers/$SERVER_NAME"
    mkdir -p "$SERVER_DIR"
    cd "$SERVER_DIR"
    
    # Check if server already exists
    if [ -f "docker-compose.yml" ]; then
        echo -e "${YELLOW}⚠️  Server '$SERVER_NAME' already exists!${NC}"
        echo -e "${CYAN}Do you want to overwrite it? (y/n): ${NC}"
        read OVERWRITE_CHOICE
        
        OVERWRITE_CHOICE=$(echo "$OVERWRITE_CHOICE" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [[ "$OVERWRITE_CHOICE" != "y" && "$OVERWRITE_CHOICE" != "yes" ]]; then
            echo -e "${LIGHT_RED}❌ Installation cancelled.${NC}"
            exit 1
        fi
        
        echo -e "${YELLOW}🛑 Stopping existing server...${NC}"
        docker compose down 2>/dev/null || true
    fi
    
    cat > docker-compose.yml << EOF
version: '3.9'

services:
  minecraft:
    image: itzg/minecraft-server:latest
    container_name: minecraft-$SERVER_NAME
    ports:
      - "$SERVER_PORT:25565"
    environment:
      EULA: "TRUE"
      VERSION: "$MC_VERSION"
      TYPE: "$SERVER_TYPE"
      ONLINE_MODE: "$ONLINE_MODE"
      DIFFICULTY: "normal"
      MAX_PLAYERS: "$MAX_PLAYERS"
      MODE: "$GAMEMODE"
      MOTD: "Welcome to $SERVER_NAME - $SERVER_TYPE Server v$MC_VERSION"
      LEVEL_NAME: "$SERVER_NAME-world"
      MEMORY: "$MEMORY"
      USE_AIKAR_FLAGS: "TRUE"
      ENABLE_RCON: "TRUE"
      RCON_PORT: "25575"
      RCON_PASSWORD: "CHANGE_ME_NOW"
    volumes:
      - ./data:/data
    restart: unless-stopped
    stdin_open: true
    tty: true
    deploy:
      resources:
        limits:
          memory: $MEMORY_LIMIT
        reservations:
          memory: $MEMORY
EOF

    echo -e "${LIGHT_GREEN}✅ Docker Compose configuration created at $SERVER_DIR/docker-compose.yml${NC}"
    sleep 2
}

# Enhanced start_server function
start_server() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              🚀 Step 5: Starting Minecraft Server 🚀            ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🎮 Starting Minecraft server...${NC}"
    cd "/opt/minecraft-servers/$SERVER_NAME"
    
    echo -e "${CYAN}📥 Pulling latest Docker image...${NC}"
    docker compose pull
    
    echo -e "${CYAN}🚀 Starting server container...${NC}"
    docker compose up -d
    
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}            🎉 Installation Completed Successfully! 🎉           ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${PINK}📊 Server details:${NC}"
    echo -e "${CYAN}  • Server Name:${NC} ${LIGHT_GREEN}$SERVER_NAME${NC}"
    echo -e "${CYAN}  • Version:${NC} ${LIGHT_GREEN}$MC_VERSION${NC}"
    echo -e "${CYAN}  • Type:${NC} ${LIGHT_GREEN}$SERVER_TYPE${NC}"
    echo -e "${CYAN}  • Port:${NC} ${LIGHT_GREEN}$SERVER_PORT${NC}"
    echo -e "${CYAN}  • Game Mode:${NC} ${LIGHT_GREEN}$GAMEMODE_NAME${NC}"
    echo -e "${CYAN}  • Cracked players:${NC} ${LIGHT_GREEN}$CRACKED_STATUS${NC}"
    echo -e "${CYAN}  • World Name:${NC} ${LIGHT_GREEN}$SERVER_NAME-world${NC}"
    echo -e "${CYAN}  • Server Directory:${NC} ${LIGHT_GREEN}/opt/minecraft-servers/$SERVER_NAME${NC}"
    echo ""
    echo -e "${PINK}⚡ Useful commands:${NC}"
    echo -e "${CYAN}  • Go to server directory:${NC} ${LIGHT_BLUE}cd /opt/minecraft-servers/$SERVER_NAME${NC}"
    echo -e "${CYAN}  • Check logs:${NC} ${LIGHT_BLUE}docker compose logs -f${NC}"
    echo -e "${CYAN}  • Stop server:${NC} ${LIGHT_BLUE}docker compose down${NC}"
    echo -e "${CYAN}  • Restart server:${NC} ${LIGHT_BLUE}docker compose restart${NC}"
    echo -e "${CYAN}  • Server console:${NC} ${LIGHT_BLUE}docker attach minecraft-$SERVER_NAME${NC}"
    echo -e "${CYAN}  • List all servers:${NC} ${LIGHT_BLUE}ls /opt/minecraft-servers/${NC}"
    echo ""
    echo -e "${LIGHT_GREEN}🎉 Server is starting! It might take a few minutes.${NC}"
    echo -e "${YELLOW}🌐 Connect with: ${WHITE}$(curl -s ipinfo.io/ip):$SERVER_PORT${NC}"
}

# Full installation function
full_installation() {
    check_root
    get_server_configuration
    update_system
    install_docker
    configure_firewall
    setup_minecraft_server
    start_server
}

# Server-only installation function
server_only_installation() {
    check_root
    check_docker_prerequisites
    if [ "$INSTALL_TYPE" == "FULL" ]; then
        full_installation
        return
    fi
    get_server_configuration
    configure_firewall  # Still configure firewall for new port
    setup_minecraft_server
    start_server
}

# Function to check Docker prerequisites for server-only installation
check_docker_prerequisites() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}              🐳 Checking Docker Prerequisites 🐳              ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    
    echo -e "${YELLOW}🔍 Checking Docker installation...${NC}"
    
    if ! command -v docker &> /dev/null; then
        echo -e "${LIGHT_RED}❌ Docker is not installed!${NC}"
        echo -e "${YELLOW}💡 Please run full installation first or install Docker manually.${NC}"
        echo ""
        echo -e "${CYAN}Would you like to switch to full installation? (y/n): ${NC}"
        read SWITCH_CHOICE
        
        SWITCH_CHOICE=$(echo "$SWITCH_CHOICE" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [[ "$SWITCH_CHOICE" == "y" || "$SWITCH_CHOICE" == "yes" ]]; then
            INSTALL_TYPE="FULL"
            echo -e "${LIGHT_GREEN}✅ Switching to full installation...${NC}"
            sleep 2
            return 0
        else
            echo -e "${LIGHT_RED}❌ Installation cancelled.${NC}"
            exit 1
        fi
    fi
    
    if ! docker compose version &> /dev/null; then
        echo -e "${LIGHT_RED}❌ Docker Compose is not available!${NC}"
        echo -e "${YELLOW}💡 Please run full installation first.${NC}"
        exit 1
    fi
    
    if ! systemctl is-active --quiet docker; then
        echo -e "${YELLOW}🔄 Starting Docker service...${NC}"
        systemctl start docker
    fi
    
    echo -e "${LIGHT_GREEN}✅ Docker is installed and running!${NC}"
    sleep 2
}

# Main execution
main() {
    show_main_menu
    
    case "$INSTALL_TYPE" in
        "FULL")
            full_installation
            ;;
        "SERVER_ONLY")
            server_only_installation
            ;;
        *)
            echo -e "${LIGHT_RED}❌ Invalid installation type${NC}"
            exit 1
            ;;
    esac
}

# Run main function
main