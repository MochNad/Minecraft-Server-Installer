# Minecraft Server Auto Installer with Docker

Script otomatis untuk menginstall Minecraft server menggunakan Docker di Ubuntu.

## Cara Menjalankan di Server Ubuntu

### Metode 1: Langsung dari GitHub (Recommended)

```bash
# 1. Update sistem terlebih dahulu
sudo apt update

# 2. Install git jika belum ada
sudo apt install -y git

# 3. Clone repository
git clone https://github.com/MochNad/minecraft-server-installer.git
cd minecraft-server-installer

# 4. Beri permission executable
chmod +x install-minecraft-docker.sh

# 5. Jalankan script
sudo ./install-minecraft-docker.sh
```

### Metode 2: Download langsung dengan wget/curl

```bash
# Download script langsung
wget https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh

# Atau menggunakan curl
curl -O https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh

# Beri permission dan jalankan
chmod +x install-minecraft-docker.sh
sudo ./install-minecraft-docker.sh
```

### Metode 3: One-liner command

```bash
# Install dan jalankan dalam satu command
curl -fsSL https://raw.githubusercontent.com/MochNad/minecraft-server-installer/main/install-minecraft-docker.sh | sudo bash
```

## Requirement Server

- Ubuntu 18.04+ atau Debian 10+
- Minimal 2GB RAM (4GB recommended)
- Minimal 10GB disk space
- Port 25565 terbuka
- Akses sudo/root

## Setelah Instalasi

Server akan berjalan otomatis di port 25565. Gunakan IP server untuk connect:

```
Server IP: YOUR_SERVER_IP:25565
```

## Management Commands

```bash
# Lihat status server
docker ps

# Lihat logs server
docker logs minecraft-server -f

# Stop server
cd /opt/minecraft-server && docker-compose down

# Start server
cd /opt/minecraft-server && docker-compose up -d

# Restart server
cd /opt/minecraft-server && docker-compose restart

# Console server (RCON)
docker exec -i minecraft-server rcon-cli
```

## Troubleshooting

### Jika port 25565 tidak bisa diakses:

```bash
# Cek firewall
sudo ufw status

# Enable port jika belum
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
```

### Jika server kehabisan memory:

```bash
# Edit docker-compose.yml
cd /opt/minecraft-server
nano docker-compose.yml

# Ubah MEMORY: "2G" menjadi "1G" atau sesuai kebutuhan
# Restart server
docker-compose restart
```
