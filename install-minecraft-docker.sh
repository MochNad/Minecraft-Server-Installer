#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}=== Minecraft Server Auto Installer with Docker ===${NC}"
echo -e "${YELLOW}Starting installation process...${NC}"
sleep 2

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run this script as root (use sudo)${NC}"
        exit 1
    fi
}

# Update system
update_system() {
    clear
    echo -e "${BLUE}=== Step 1: Updating System ===${NC}"
    echo -e "${YELLOW}Updating system packages...${NC}"
    apt update && apt upgrade -y
    apt install -y curl wget ufw
    echo -e "${GREEN}System update completed!${NC}"
    sleep 2
}

# Install Docker and Docker Compose
install_docker() {
    clear
    echo -e "${BLUE}=== Step 2: Installing Docker ===${NC}"
    echo -e "${YELLOW}Installing Docker and Docker Compose...${NC}"
    if ! command -v docker &> /dev/null; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        usermod -aG docker $SUDO_USER
        systemctl enable docker
        systemctl start docker
        rm get-docker.sh
        echo -e "${GREEN}Docker installed successfully${NC}"
    else
        echo -e "${GREEN}Docker already installed${NC}"
    fi
    
    # Install latest docker-compose
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${YELLOW}Installing latest Docker Compose...${NC}"
        COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d'"' -f4)
        curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        echo -e "${GREEN}Docker Compose $COMPOSE_VERSION installed successfully${NC}"
    else
        echo -e "${GREEN}Docker Compose already installed${NC}"
        echo -e "${YELLOW}Current version: $(docker-compose --version)${NC}"
    fi
    echo -e "${GREEN}Docker installation completed!${NC}"
    sleep 2
}

# Configure firewall
configure_firewall() {
    clear
    echo -e "${BLUE}=== Step 3: Configuring Firewall ===${NC}"
    echo -e "${YELLOW}Configuring firewall for port 25565...${NC}"
    ufw allow 25565/tcp
    ufw allow 25565/udp
    echo -e "${GREEN}Port 25565 enabled in firewall${NC}"
    echo -e "${GREEN}Firewall configuration completed!${NC}"
    sleep 2
}

# Get Minecraft version from user
get_minecraft_version() {
    clear
    echo -e "${BLUE}=== Step 4: Select Minecraft Version ===${NC}"
    echo -e "${BLUE}Available Minecraft versions:${NC}"
    echo "- latest (newest stable)"
    echo "- 1.21.81 (latest bedrock compatible)"
    echo "- 1.21.7"
    echo "- 1.21.4"
    echo "- 1.21.1"
    echo "- 1.20.4"
    echo "- 1.19.4"
    echo "- 1.18.2"
    echo "- 1.16.5"
    echo ""
    
    while true; do
        read -p "Enter Minecraft version (or 'latest' for newest): " MC_VERSION
        if [ ! -z "$MC_VERSION" ]; then
            break
        fi
        echo -e "${RED}Please enter a valid version${NC}"
    done
    
    echo -e "${GREEN}Selected version: $MC_VERSION${NC}"
    sleep 2
}

# Get server type from user
get_server_type() {
    clear
    echo -e "${BLUE}=== Step 5: Select Server Type ===${NC}"
    echo -e "${BLUE}Available server types:${NC}"
    echo "1. VANILLA (Default Minecraft)"
    echo "2. FORGE (Mod support)"
    echo "3. FABRIC (Lightweight mod support)"
    echo "4. PAPER (Performance optimized)"
    echo "5. SPIGOT (Plugin support)"
    echo "6. PURPUR (Enhanced Paper)"
    echo "7. MOHIST (Forge + Bukkit plugins)"
    echo ""
    
    while true; do
        read -p "Select server type (1-7): " SERVER_CHOICE
        case $SERVER_CHOICE in
            1) SERVER_TYPE="VANILLA"; break;;
            2) SERVER_TYPE="FORGE"; break;;
            3) SERVER_TYPE="FABRIC"; break;;
            4) SERVER_TYPE="PAPER"; break;;
            5) SERVER_TYPE="SPIGOT"; break;;
            6) SERVER_TYPE="PURPUR"; break;;
            7) SERVER_TYPE="MOHIST"; break;;
            *) echo -e "${RED}Please enter a number between 1-7${NC}";;
        esac
    done
    
    echo -e "${GREEN}Selected server type: $SERVER_TYPE${NC}"
    sleep 2
}

# Create minecraft directory and docker-compose
setup_minecraft_server() {
    clear
    echo -e "${BLUE}=== Step 6: Setting Up Server Configuration ===${NC}"
    echo -e "${YELLOW}Setting up Minecraft server...${NC}"
    
    mkdir -p /opt/minecraft-server
    cd /opt/minecraft-server
    
    # Create docker-compose.yml with latest version
    cat > docker-compose.yml << EOF
version: '3.9'

services:
  minecraft:
    image: itzg/minecraft-server:latest
    container_name: minecraft-server
    ports:
      - "25565:25565"
    environment:
      EULA: "TRUE"
      VERSION: "$MC_VERSION"
      TYPE: "$SERVER_TYPE"
      ONLINE_MODE: "FALSE"
      DIFFICULTY: "normal"
      MAX_PLAYERS: "20"
      MOTD: "Welcome to $SERVER_TYPE Server v$MC_VERSION - Cracked Players Welcome!"
      ALLOW_FLIGHT: "TRUE"
      SPAWN_PROTECTION: "0"
      MEMORY: "2G"
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
          memory: 3G
        reservations:
          memory: 2G

volumes:
  minecraft-data:
    driver: local
EOF

    echo -e "${GREEN}Docker configuration created${NC}"
    echo -e "${GREEN}Server configuration completed!${NC}"
    sleep 2
}

# Start the server
start_server() {
    clear
    echo -e "${BLUE}=== Step 7: Starting Minecraft Server ===${NC}"
    echo -e "${YELLOW}Starting Minecraft server...${NC}"
    cd /opt/minecraft-server
    
    # Pull the latest image
    docker-compose pull
    
    # Start the server
    docker-compose up -d
    
    clear
    echo -e "${GREEN}=== Installation Completed Successfully! ===${NC}"
    echo ""
    echo -e "${BLUE}Server details:${NC}"
    echo -e "- Version: $MC_VERSION"
    echo -e "- Type: $SERVER_TYPE"
    echo -e "- Port: 25565"
    echo -e "- RCON Port: 25575 (no password)"
    echo -e "- Cracked players: ${GREEN}ENABLED${NC}"
    echo -e "- Max players: 20"
    echo -e "- Memory: 2GB (limit: 3GB)"
    echo -e "- Aikar Flags: ${GREEN}ENABLED${NC}"
    echo ""
    echo -e "${YELLOW}Useful commands:${NC}"
    echo -e "- Check logs: ${BLUE}docker logs minecraft-server -f${NC}"
    echo -e "- Stop server: ${BLUE}cd /opt/minecraft-server && docker-compose down${NC}"
    echo -e "- Restart server: ${BLUE}cd /opt/minecraft-server && docker-compose restart${NC}"
    echo -e "- Server console: ${BLUE}docker exec -i minecraft-server rcon-cli${NC}"
    echo -e "- RCON connect: ${BLUE}docker exec -i minecraft-server rcon-cli${NC}"
    echo ""
    echo -e "${GREEN}Installation completed! Server will be ready in a few minutes.${NC}"
    echo -e "${YELLOW}You can connect using your server's IP address on port 25565${NC}"
    echo -e "${BLUE}First startup may take longer for $SERVER_TYPE server type${NC}"
}

# Main execution
main() {
    check_root
    update_system
    install_docker
    configure_firewall
    get_minecraft_version
    get_server_type
    setup_minecraft_server
    start_server
}

# Run main function
main
