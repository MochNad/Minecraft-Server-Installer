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
    
    # Fixed input method - remove -r and add proper validation
    while true; do
        echo -ne "${CYAN}🎮 Select Minecraft version (1-9): ${NC}"
        read VERSION_CHOICE
        
        # Remove any whitespace and validate
        VERSION_CHOICE=$(echo "$VERSION_CHOICE" | tr -d '[:space:]')
        
        case "$VERSION_CHOICE" in
            1)
                MC_VERSION="latest"
                echo -e "${LIGHT_GREEN}✅ Selected: latest${NC}"
                break
                ;;
            2)
                MC_VERSION="1.21.81"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.21.81${NC}"
                break
                ;;
            3)
                MC_VERSION="1.21.7"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.21.7${NC}"
                break
                ;;
            4)
                MC_VERSION="1.21.4"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.21.4${NC}"
                break
                ;;
            5)
                MC_VERSION="1.21.1"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.21.1${NC}"
                break
                ;;
            6)
                MC_VERSION="1.20.4"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.20.4${NC}"
                break
                ;;
            7)
                MC_VERSION="1.19.4"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.19.4${NC}"
                break
                ;;
            8)
                MC_VERSION="1.18.2"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.18.2${NC}"
                break
                ;;
            9)
                MC_VERSION="1.16.5"
                echo -e "${LIGHT_GREEN}✅ Selected: 1.16.5${NC}"
                break
                ;;
            *)
                echo -e "${LIGHT_RED}❌ Invalid input. Please enter a number between 1-9${NC}"
                ;;
        esac
    done
    
    echo ""
    sleep 1
    
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
        echo -ne "${CYAN}⚡ Select server type (1-7): ${NC}"
        read SERVER_CHOICE
        
        # Remove any whitespace
        SERVER_CHOICE=$(echo "$SERVER_CHOICE" | tr -d '[:space:]')
        
        case "$SERVER_CHOICE" in
            1)
                SERVER_TYPE="VANILLA"
                echo -e "${LIGHT_GREEN}✅ Selected: VANILLA${NC}"
                break
                ;;
            2)
                SERVER_TYPE="FORGE"
                echo -e "${LIGHT_GREEN}✅ Selected: FORGE${NC}"
                break
                ;;
            3)
                SERVER_TYPE="FABRIC"
                echo -e "${LIGHT_GREEN}✅ Selected: FABRIC${NC}"
                break
                ;;
            4)
                SERVER_TYPE="PAPER"
                echo -e "${LIGHT_GREEN}✅ Selected: PAPER${NC}"
                break
                ;;
            5)
                SERVER_TYPE="SPIGOT"
                echo -e "${LIGHT_GREEN}✅ Selected: SPIGOT${NC}"
                break
                ;;
            6)
                SERVER_TYPE="PURPUR"
                echo -e "${LIGHT_GREEN}✅ Selected: PURPUR${NC}"
                break
                ;;
            7)
                SERVER_TYPE="MOHIST"
                echo -e "${LIGHT_GREEN}✅ Selected: MOHIST${NC}"
                break
                ;;
            *)
                echo -e "${LIGHT_RED}❌ Please enter a number between 1-7${NC}"
                ;;
        esac
    done
    
    echo ""
    sleep 1
    
    # Get server port
    while true; do
        echo -ne "${CYAN}🌐 Enter server port (default 25565): ${NC}"
        read SERVER_PORT
        
        # Remove any whitespace
        SERVER_PORT=$(echo "$SERVER_PORT" | tr -d '[:space:]')
        
        if [ -z "$SERVER_PORT" ]; then
            SERVER_PORT="25565"
            echo -e "${LIGHT_GREEN}✅ Using default port: 25565${NC}"
            break
        elif [[ "$SERVER_PORT" =~ ^[0-9]+$ ]] && [ "$SERVER_PORT" -ge 1024 ] && [ "$SERVER_PORT" -le 65535 ]; then
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
        
        # Remove any whitespace and convert to lowercase
        CRACKED_CHOICE=$(echo "$CRACKED_CHOICE" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [ -z "$CRACKED_CHOICE" ] || [ "$CRACKED_CHOICE" = "y" ] || [ "$CRACKED_CHOICE" = "yes" ]; then
            ONLINE_MODE="FALSE"
            CRACKED_STATUS="ENABLED"
            echo -e "${LIGHT_GREEN}✅ Cracked players: ENABLED${NC}"
            break
        elif [ "$CRACKED_CHOICE" = "n" ] || [ "$CRACKED_CHOICE" = "no" ]; then
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
        
        # Remove any whitespace
        MAX_PLAYERS=$(echo "$MAX_PLAYERS" | tr -d '[:space:]')
        
        if [ -z "$MAX_PLAYERS" ]; then
            MAX_PLAYERS="20"
            echo -e "${LIGHT_GREEN}✅ Max players: 20${NC}"
            break
        elif [[ "$MAX_PLAYERS" =~ ^[0-9]+$ ]] && [ "$MAX_PLAYERS" -ge 1 ] && [ "$MAX_PLAYERS" -le 200 ]; then
            echo -e "${LIGHT_GREEN}✅ Max players: $MAX_PLAYERS${NC}"
            break
        else
            echo -e "${LIGHT_RED}❌ Please enter a number between 1-200${NC}"
        fi
    done
    
    echo ""
    sleep 1
    
    # Get memory allocation
    echo -e "${PINK}💾 Available memory options:${NC}"
    echo -e "${LIGHT_GREEN}1.${NC} ${WHITE}1GB${NC} ${ORANGE}(for low-end VPS)${NC}"
    echo -e "${LIGHT_GREEN}2.${NC} ${WHITE}2GB${NC} ${ORANGE}(recommended minimum)${NC}"
    echo -e "${LIGHT_GREEN}3.${NC} ${WHITE}3GB${NC} ${ORANGE}(good performance)${NC}"
    echo -e "${LIGHT_GREEN}4.${NC} ${WHITE}4GB${NC} ${ORANGE}(high performance)${NC}"
    echo -e "${LIGHT_GREEN}5.${NC} ${WHITE}Custom amount${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}🔋 Select memory allocation (1-5): ${NC}"
        read MEMORY_CHOICE
        
        # Remove any whitespace
        MEMORY_CHOICE=$(echo "$MEMORY_CHOICE" | tr -d '[:space:]')
        
        case "$MEMORY_CHOICE" in
            1)
                MEMORY="1G"
                MEMORY_LIMIT="1536M"
                echo -e "${LIGHT_GREEN}✅ Memory: 1GB${NC}"
                break
                ;;
            2)
                MEMORY="2G"
                MEMORY_LIMIT="3G"
                echo -e "${LIGHT_GREEN}✅ Memory: 2GB${NC}"
                break
                ;;
            3)
                MEMORY="3G"
                MEMORY_LIMIT="4G"
                echo -e "${LIGHT_GREEN}✅ Memory: 3GB${NC}"
                break
                ;;
            4)
                MEMORY="4G"
                MEMORY_LIMIT="5G"
                echo -e "${LIGHT_GREEN}✅ Memory: 4GB${NC}"
                break
                ;;
            5)
                while true; do
                    echo -ne "${CYAN}💾 Enter custom memory (e.g., 512M, 1G, 2G): ${NC}"
                    read CUSTOM_MEMORY
                    
                    # Remove any whitespace and convert to uppercase
                    CUSTOM_MEMORY=$(echo "$CUSTOM_MEMORY" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
                    
                    if [[ "$CUSTOM_MEMORY" =~ ^[0-9]+[MG]$ ]]; then
                        MEMORY="$CUSTOM_MEMORY"
                        # Calculate limit (add buffer)
                        if [[ "$CUSTOM_MEMORY" =~ ^[0-9]+M$ ]]; then
                            NUM=$(echo "$CUSTOM_MEMORY" | sed 's/M//')
                            MEMORY_LIMIT="$((NUM + 512))M"
                        else
                            NUM=$(echo "$CUSTOM_MEMORY" | sed 's/G//')
                            MEMORY_LIMIT="$((NUM + 1))G"
                        fi
                        echo -e "${LIGHT_GREEN}✅ Memory: $MEMORY${NC}"
                        break
                    else
                        echo -e "${LIGHT_RED}❌ Please enter a valid memory format (e.g., 512M, 2G)${NC}"
                    fi
                done
                break
                ;;
            *)
                echo -e "${LIGHT_RED}❌ Please enter a number between 1-5${NC}"
                ;;
        esac
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
        
        # Remove any whitespace and convert to lowercase
        CONFIRM=$(echo "$CONFIRM" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
        
        if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "yes" ]; then
            echo -e "${LIGHT_GREEN}🚀 Starting installation with your configuration...${NC}"
            sleep 2
            break
        elif [ "$CONFIRM" = "n" ] || [ "$CONFIRM" = "no" ]; then
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

# Setup Minecraft server
setup_minecraft_server() {
    clear
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LIGHT_BLUE}║${WHITE}        🔧 Step 4: Setting Up Server Configuration 🔧        ${LIGHT_BLUE}║${NC}"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}🎮 Setting up Minecraft server with your configuration...${NC}"
    
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
      RCON_PASSWORD: ""
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

    echo -e "${LIGHT_GREEN}✅ Docker configuration created${NC}"
    echo -e "${LIGHT_GREEN}✅ Server configuration completed!${NC}"
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
    echo -e "${CYAN}📥 Pulling latest Docker image...${NC}"
    docker-compose pull
    
    # Start the server
    echo -e "${CYAN}🚀 Starting server container...${NC}"
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