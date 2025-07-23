#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# --- MENU FUNCTIONS ---

show_main_menu() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}               🎯 Installation Type Selection 🎯               ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}📋 Please select your installation type:${NC}"
    echo -e "\n${GREEN}1.${NC} ${WHITE}Full Installation${NC} ${ORANGE}(System update + Docker + Firewall + Server)${NC}"
    echo -e "${GREEN}2.${NC} ${WHITE}Add New Server Only${NC} ${ORANGE}(Requires Docker already installed)${NC}\n"
    
    while true; do
        echo -ne "${CYAN}🔧 Select installation type (1-2): ${NC}"
        read -r INSTALL_CHOICE
        case "$INSTALL_CHOICE" in
            1) INSTALL_TYPE="FULL"; echo -e "${GREEN}✅ Selected: Full Installation${NC}"; break ;;
            2) INSTALL_TYPE="SERVER_ONLY"; echo -e "${GREEN}✅ Selected: Add New Server Only${NC}"; break ;;
            *) echo -e "${RED}❌ Please enter 1 or 2${NC}" ;;
        esac
    done
}

select_edition_menu() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}                 💎 Minecraft Edition 💎                  ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}📋 Please select the server edition:${NC}"
    echo -e "\n${GREEN}1.${NC} ${WHITE}Java Edition${NC} ${ORANGE}(PC/Mac, supports mods/plugins)${NC}"
    echo -e "${GREEN}2.${NC} ${WHITE}Bedrock Edition${NC} ${ORANGE}(Mobile, Console, Windows 10/11)${NC}\n"

    while true; do
        echo -ne "${CYAN}🔧 Select edition (1-2): ${NC}"
        read -r EDITION_CHOICE_NUM
        case "$EDITION_CHOICE_NUM" in
            1) EDITION_CHOICE="JAVA"; echo -e "${GREEN}✅ Selected: Java Edition${NC}"; break ;;
            2) EDITION_CHOICE="BEDROCK"; echo -e "${GREEN}✅ Selected: Bedrock Edition${NC}"; break ;;
            *) echo -e "${RED}❌ Please enter 1 or 2${NC}" ;;
        esac
    done
}


# --- CONFIGURATION FUNCTIONS ---

get_java_configuration() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}            ☕ Java Edition Server Configuration ☕            ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    
    # Get Server Name
    while true; do
        echo -ne "\n${CYAN}🏷️  Enter a unique server name (no spaces, e.g., 'java-survival'): ${NC}"
        read -r SERVER_NAME
        if [[ "$SERVER_NAME" =~ ^[a-z0-9_-]+$ ]] && [ ! -d "/opt/minecraft-servers/$SERVER_NAME" ]; then
            echo -e "${GREEN}✅ Server name: $SERVER_NAME${NC}"
            break
        else
            echo -e "${RED}❌ Invalid or already exists. Use lowercase letters, numbers, -, _ only.${NC}"
        fi
    done
    
    # Get Minecraft Version for Java
    echo -e "\n${PURPLE}🎯 Available Java versions:${NC}"
    echo "1. latest" "2. 1.21" "3. 1.20.4" "4. 1.19.4" "5. 1.18.2" "6. 1.16.5" "7. Other (custom version)"
    while true; do
        echo -ne "${CYAN}🎮 Select version (1-7): ${NC}"
        read -r V_CHOICE
        case "$V_CHOICE" in
            1) MC_VERSION="latest"; break;; 
            2) MC_VERSION="1.21"; break;;
            3) MC_VERSION="1.20.4"; break;; 
            4) MC_VERSION="1.19.4"; break;;
            5) MC_VERSION="1.18.2"; break;; 
            6) MC_VERSION="1.16.5"; break;;
            7) 
                while true; do
                    echo -ne "${CYAN}📝 Enter custom version (e.g., 1.20.1, 1.19.2): ${NC}"
                    read -r CUSTOM_VERSION
                    if [[ "$CUSTOM_VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
                        MC_VERSION="$CUSTOM_VERSION"
                        echo -e "${GREEN}✅ Custom version: $MC_VERSION${NC}"
                        break
                    else
                        echo -e "${RED}❌ Invalid format. Use format like 1.20.1 or 1.19.2${NC}"
                    fi
                done
                break;;
            *) echo -e "${RED}❌ Invalid input.${NC}";;
        esac
    done
    echo -e "${GREEN}✅ Version: $MC_VERSION${NC}"

    # Get Server Type for Java
    echo -e "\n${PURPLE}🔧 Available server types:${NC}"
    echo "1. VANILLA" "2. PAPER" "3. FORGE" "4. FABRIC" "5. SPIGOT"
    while true; do
        echo -ne "${CYAN}⚡ Select server type (1-5): ${NC}"
        read -r T_CHOICE
        case "$T_CHOICE" in
            1) SERVER_TYPE="VANILLA"; break;; 2) SERVER_TYPE="PAPER"; break;;
            3) SERVER_TYPE="FORGE"; break;; 4) SERVER_TYPE="FABRIC"; break;;
            5) SERVER_TYPE="SPIGOT"; break;;
            *) echo -e "${RED}❌ Invalid input.${NC}";;
        esac
    done
    echo -e "${GREEN}✅ Type: $SERVER_TYPE${NC}"

    # ***FIX: Moved Cracked Support question here***
    echo -e "\n${PURPLE}🔓 Cracked player support (allows non-premium players):${NC}"
    while true; do
        echo -ne "${CYAN}Enable cracked support? (y/n, default n): ${NC}"
        read -r CRACKED_CHOICE
        CRACKED_CHOICE=${CRACKED_CHOICE:-n}
        case "$CRACKED_CHOICE" in
            [yY]|[yY][eE][sS]) 
                ONLINE_MODE="FALSE"
                CRACKED_STATUS="ENABLED"
                echo -e "${GREEN}✅ Cracked support: ENABLED${NC}"
                break;;
            [nN]|[nN][oO]) 
                ONLINE_MODE="TRUE"
                CRACKED_STATUS="DISABLED"
                echo -e "${GREEN}✅ Cracked support: DISABLED${NC}"
                break;;
            *) echo -e "${RED}❌ Please enter y or n${NC}";;
        esac
    done

    # Call common configuration
    get_common_configuration
}

get_bedrock_configuration() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}           📱 Bedrock Edition Server Configuration 📱           ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"

    # Get Server Name
    while true; do
        echo -ne "\n${CYAN}🏷️  Enter a unique server name (no spaces, e.g., 'bedrock-friends'): ${NC}"
        read -r SERVER_NAME
        if [[ "$SERVER_NAME" =~ ^[a-z0-9_-]+$ ]] && [ ! -d "/opt/minecraft-servers/$SERVER_NAME" ]; then
            echo -e "${GREEN}✅ Server name: $SERVER_NAME${NC}"
            break
        else
            echo -e "${RED}❌ Invalid or already exists. Use lowercase letters, numbers, -, _ only.${NC}"
        fi
    done

    # Get Minecraft Version for Bedrock
    echo -e "\n${PURPLE}🎯 Available Bedrock versions:${NC}"
    echo "1. latest (Stable)" "2. preview (Beta)" "3. Other (custom version)"
    while true; do
        echo -ne "${CYAN}🎮 Select version (1-3): ${NC}"
        read -r V_CHOICE
        case "$V_CHOICE" in
            1) MC_VERSION="latest"; break;; 
            2) MC_VERSION="preview"; break;;
            3) 
                while true; do
                    echo -ne "${CYAN}📝 Enter custom version (e.g., 1.20.40.01, 1.19.83.01): ${NC}"
                    read -r CUSTOM_VERSION
                    if [[ "$CUSTOM_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || [[ "$CUSTOM_VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
                        MC_VERSION="$CUSTOM_VERSION"
                        echo -e "${GREEN}✅ Custom version: $MC_VERSION${NC}"
                        break
                    else
                        echo -e "${RED}❌ Invalid format. Use format like 1.20.40.01 or 1.20.1${NC}"
                    fi
                done
                break;;
            *) echo -e "${RED}❌ Invalid input.${NC}";;
        esac
    done
    echo -e "${GREEN}✅ Version: $MC_VERSION${NC}"
    
    # ***FIX: Set Bedrock specific values here***
    ONLINE_MODE="TRUE"
    CRACKED_STATUS="N/A"

    # Common Configuration
    get_common_configuration
}

get_common_configuration() {
    # Get Server Port
    while true; do
        echo -ne "\n${CYAN}🌐 Enter server port (Java default: 25565, Bedrock default: 19132): ${NC}"
        read -r SERVER_PORT
        DEFAULT_PORT=$([ "$EDITION_CHOICE" == "JAVA" ] && echo "25565" || echo "19132")
        SERVER_PORT=${SERVER_PORT:-$DEFAULT_PORT}
        if [[ "$SERVER_PORT" =~ ^[0-9]+$ ]] && [ "$SERVER_PORT" -ge 1024 ] && [ "$SERVER_PORT" -le 65535 ]; then
            echo -e "${GREEN}✅ Port: $SERVER_PORT${NC}"
            break
        else
            echo -e "${RED}❌ Invalid port (1024-65535).${NC}"
        fi
    done

    # Get Game Mode
    echo -e "\n${PURPLE}🎮 Available game modes:${NC}"
    echo "1. Survival" "2. Creative" "3. Adventure"
    while true; do
        echo -ne "${CYAN}🎯 Select game mode (1-3, default 1): ${NC}"
        read -r GAMEMODE_CHOICE
        GAMEMODE_CHOICE=${GAMEMODE_CHOICE:-1}
        case "$GAMEMODE_CHOICE" in
            1) GAMEMODE="survival"; break;; 
            2) GAMEMODE="creative"; break;;
            3) GAMEMODE="adventure"; break;;
            *) echo -e "${RED}❌ Invalid input.${NC}";;
        esac
    done
    echo -e "${GREEN}✅ Game mode: $GAMEMODE${NC}"

    # Get Memory Allocation
    echo -e "\n${PURPLE}💾 Memory options:${NC}"
    echo "1. 1GB" "2. 2GB" "3. 3GB" "4. 4GB"
    while true; do
        echo -ne "${CYAN}🔋 Select memory allocation (1-4, default 2): ${NC}"
        read -r MEM_CHOICE
        MEM_CHOICE=${MEM_CHOICE:-2}
        case "$MEM_CHOICE" in
            1) MEMORY="1G"; break;; 
            2) MEMORY="2G"; break;;
            3) MEMORY="3G"; break;; 
            4) MEMORY="4G"; break;;
            *) echo -e "${RED}❌ Invalid input.${NC}";;
        esac
    done
    echo -e "${GREEN}✅ Memory: $MEMORY${NC}"

    confirm_configuration
}

confirm_configuration() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}                 📋 Configuration Summary 📋                 ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${PURPLE}🏷️  Server Name:${NC} ${WHITE}$SERVER_NAME${NC}"
    echo -e "${PURPLE}💎 Edition:${NC}     ${WHITE}$EDITION_CHOICE${NC}"
    echo -e "${PURPLE}🎮 Version:${NC}     ${WHITE}$MC_VERSION${NC}"
    if [ "$EDITION_CHOICE" == "JAVA" ]; then
        echo -e "${PURPLE}⚡ Type:${NC}        ${WHITE}$SERVER_TYPE${NC}"
        echo -e "${PURPLE}🔓 Cracked:${NC}     ${WHITE}$CRACKED_STATUS${NC}"
    fi
    echo -e "${PURPLE}🌐 Port:${NC}        ${WHITE}$SERVER_PORT${NC}"
    echo -e "${PURPLE}🎯 Game Mode:${NC}   ${WHITE}$GAMEMODE${NC}"
    echo -e "${PURPLE}💾 Memory:${NC}      ${WHITE}$MEMORY${NC}"
    echo ""
    
    while true; do
        echo -ne "${CYAN}✅ Confirm and start installation? (y/n): ${NC}"
        read -r CONFIRM
        case "$CONFIRM" in
            [yY]|[yY][eE][sS]) echo -e "${GREEN}🚀 Starting installation...${NC}"; break;;
            [nN]|[nN][oO]) echo -e "${RED}❌ Installation cancelled.${NC}"; exit 0;;
            *) echo -e "${RED}Invalid input.${NC}";;
        esac
    done
}


# --- INSTALLATION & SETUP FUNCTIONS ---

check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run this script as root (use sudo)${NC}"
        exit 1
    fi
}

check_docker_prerequisites() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}               🐳 Checking Docker Prerequisites 🐳               ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    
    if ! command -v docker &> /dev/null; then
        echo -e "\n${RED}❌ Docker is not installed!${NC}"
        while true; do
            echo -ne "${CYAN}Would you like to switch to full installation to install it? (y/n): ${NC}"
            read -r SWITCH_CHOICE
            case "$SWITCH_CHOICE" in
                y|yes) INSTALL_TYPE="FULL"; echo -e "${GREEN}✅ Switching to full installation...${NC}"; return;;
                n|no) echo -e "${RED}❌ Installation cancelled.${NC}"; exit 1;;
                *) echo -e "${RED}Invalid input.${NC}";;
            esac
        done
    fi
    echo -e "\n${GREEN}✅ Docker is installed.${NC}"
}

update_system() {
    echo -e "\n${YELLOW}🔄 Updating system packages...${NC}"
    apt-get update >/dev/null 2>&1 && apt-get upgrade -y >/dev/null 2>&1
    echo -e "${GREEN}✅ System updated.${NC}"
}

install_docker() {
    echo -e "\n${YELLOW}🐳 Installing Docker...${NC}"
    apt-get install -y ca-certificates curl >/dev/null 2>&1
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update >/dev/null 2>&1
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null 2>&1
    if [ -n "$SUDO_USER" ]; then usermod -aG docker "$SUDO_USER"; fi
    systemctl enable --now docker >/dev/null 2>&1
    echo -e "${GREEN}✅ Docker installed.${NC}"
}

configure_firewall() {
    echo -e "\n${YELLOW}🔥 Configuring firewall...${NC}"
    if ! command -v ufw &> /dev/null; then
        apt-get install -y ufw >/dev/null 2>&1
    fi
    ufw allow 22/tcp >/dev/null
    PORT_TYPE=$([ "$EDITION_CHOICE" == "JAVA" ] && echo "tcp" || echo "udp")
    ufw allow "$SERVER_PORT/$PORT_TYPE" >/dev/null
    echo "y" | ufw enable >/dev/null
    echo -e "${GREEN}✅ Firewall configured to allow port $SERVER_PORT.${NC}"
}

setup_minecraft_server() {
    SERVER_DIR="/opt/minecraft-servers/$SERVER_NAME"
    echo -e "\n${YELLOW}🔧 Creating server files in $SERVER_DIR...${NC}"
    mkdir -p "$SERVER_DIR"
    
    # Use different Docker images and ports based on edition
    if [ "$EDITION_CHOICE" == "JAVA" ]; then
        DOCKER_IMAGE="itzg/minecraft-server"
        CONTAINER_PORT="25565"
        ADDITIONAL_ENV="
      TYPE: \"$SERVER_TYPE\"
      ONLINE_MODE: \"$ONLINE_MODE\""
    else # Bedrock
        DOCKER_IMAGE="itzg/minecraft-bedrock-server"
        CONTAINER_PORT="19132"
        ADDITIONAL_ENV="" # No extra env for bedrock in this simple setup
    fi

    cat > "$SERVER_DIR/docker-compose.yml" << EOF
version: '3.9'
services:
  mc:
    image: $DOCKER_IMAGE
    container_name: mc-$SERVER_NAME
    ports:
      - "$SERVER_PORT:$CONTAINER_PORT"
    environment:
      EULA: "TRUE"
      VERSION: "$MC_VERSION"
      MEMORY: "$MEMORY"
      GAMEMODE: "$GAMEMODE"$ADDITIONAL_ENV
    volumes:
      - ./data:/data
    restart: unless-stopped
EOF
    echo -e "${GREEN}✅ docker-compose.yml created.${NC}"
}

start_server() {
    cd "/opt/minecraft-servers/$SERVER_NAME" || exit
    echo -e "\n${YELLOW}🚀 Starting server '$SERVER_NAME'...${NC}"
    docker compose up -d
    
    clear
    PUBLIC_IP=$(curl -s ipinfo.io/ip)
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}            🎉 Installation Completed Successfully! 🎉           ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "\n${WHITE}You can now connect to your Minecraft ($EDITION_CHOICE) server at:${NC}"
    echo -e "${YELLOW}Server IP: $PUBLIC_IP:$SERVER_PORT${NC}"
    echo -e "\n${PURPLE}⚡ Useful commands:${NC}"
    echo -e "${CYAN}  Go to server directory: ${WHITE}cd /opt/minecraft-servers/$SERVER_NAME${NC}"
    echo -e "${CYAN}  Check server logs:      ${WHITE}docker compose logs -f${NC}"
    echo -e "${CYAN}  Stop the server:        ${WHITE}docker compose down${NC}\n"
}


# --- MAIN EXECUTION FLOW ---

main() {
    check_root
    show_main_menu
    select_edition_menu

    # Handle prerequisites first
    if [ "$INSTALL_TYPE" == "SERVER_ONLY" ]; then
        check_docker_prerequisites
    fi

    # Handle full installation dependencies if INSTALL_TYPE is or was changed to "FULL"
    if [ "$INSTALL_TYPE" == "FULL" ]; then
        update_system
        install_docker
    fi
    
    # Get configuration based on edition choice
    if [ "$EDITION_CHOICE" == "JAVA" ]; then
        get_java_configuration
    else
        get_bedrock_configuration
    fi

    # Install the server
    configure_firewall
    setup_minecraft_server
    start_server
}

main