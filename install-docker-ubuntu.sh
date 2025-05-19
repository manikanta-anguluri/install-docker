#!/bin/bash

# Exit immediately on error
set -e

echo "Removing old versions of Docker (if any)..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do 
    sudo apt-get remove -y "$pkg" || true
done

sudo apt-get autoremove -y

echo "Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

echo "Adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

echo "Installing Docker Engine and related components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker installed successfully."

# --- POST-INSTALLATION STEPS ---
echo "Configuring Docker to run without sudo..."

# Create docker group if not exists
if ! getent group docker > /dev/null; then
    sudo groupadd docker
    echo "Docker group created."
fi

# Add all normal users to docker group
echo "Adding all non-system users to docker group..."
USERS=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd)
for user in $USERS; do
    sudo usermod -aG docker "$user"
    echo "User '$user' added to docker group."
done
newgrp docker
echo "Done. All non-system users can now use Docker without sudo after re-logging in."
