#!/bin/bash

# ============================================
# Jenkins CI/CD Workshop Setup Script
# For: GCP e2-micro VM (Debian Bookworm)
# ============================================

set -e  # Exit on any error

echo "========================================"
echo "Step 1: Update System Packages"
echo "========================================"
sudo apt-get update

echo "========================================"
echo "Step 2: Install Java 21 (Eclipse Temurin)"
echo "========================================"
# Download Java 21 from Adoptium
cd /tmp
curl -L -o temurin21.tar.gz "https://api.adoptium.net/v3/binary/latest/21/ga/linux/x64/jdk/hotspot/normal/adoptium"

# Extract to /opt/java
sudo mkdir -p /opt/java
sudo tar -xzf temurin21.tar.gz -C /opt/java

# Find the extracted folder name
JAVA_DIR=$(ls /opt/java | head -1)

# Set Java as default
sudo update-alternatives --install /usr/bin/java java /opt/java/$JAVA_DIR/bin/java 1
sudo update-alternatives --set java /opt/java/$JAVA_DIR/bin/java

# Verify Java installation
echo "Java version:"
java -version

echo "========================================"
echo "Step 3: Install Jenkins"
echo "========================================"
# Add Jenkins repository key
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install Jenkins 2.479.3 (compatible with Java 17/21)
sudo apt-get update
sudo apt-get install jenkins=2.479.3 -y

echo "========================================"
echo "Step 4: Install Git"
echo "========================================"
sudo apt-get install git -y

echo "========================================"
echo "Step 5: Install nginx"
echo "========================================"
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "========================================"
echo "Step 6: Configure Permissions"
echo "========================================"
# Add jenkins user to www-data group
sudo usermod -aG www-data jenkins

# Set ownership of nginx directory
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 775 /var/www/html/

# Allow Jenkins to run cp and chown without password
sudo sh -c 'echo "jenkins ALL=(ALL) NOPASSWD: /usr/bin/cp, /usr/bin/chown, /usr/bin/mkdir" > /etc/sudoers.d/jenkins'
sudo chmod 440 /etc/sudoers.d/jenkins

echo "========================================"
echo "Step 7: Start Jenkins"
echo "========================================"

sudo systemctl start jenkins
sudo systemctl enable jenkins

# Wait for Jenkins to start
echo "Waiting for Jenkins to start..."
sleep 10

echo "========================================"
echo "SETUP COMPLETE!"
echo "========================================"
echo ""
echo "Jenkins URL: http://$(curl -s ifconfig.me):8080"
echo "nginx URL:   http://$(curl -s ifconfig.me)"
echo ""
echo "Get Jenkins initial password with:"
echo "  sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo ""
echo "========================================"
echo "FIREWALL RULES NEEDED (in GCP Console):"
echo "========================================"
echo "1. Allow TCP port 8080 (Jenkins)"
echo "2. Allow TCP port 80 (nginx/HTTP)"
echo ""
echo "Go to: VPC Network → Firewall → Create Firewall Rule"
echo "========================================"
