# Docker Installation Script for Ubuntu

This repository contains a shell script to install Docker Engine on Ubuntu and configure it so that **all normal (non-system) users** can use Docker without requiring `sudo`.

## 🔧 What the Script Does

- Removes old Docker and container packages (if any)
- Adds Docker's official GPG key and APT repository
- Installs Docker Engine, CLI, Buildx, and Compose plugin
- Creates the `docker` group (if not exists)
- Adds **all users with UID ≥ 1000** to the `docker` group
- Prompts user to restart session for changes to take effect

## 📥 Quick Install (One-liner)

Run the following command to install Docker on your Ubuntu system:

```bash
bash <(curl -s https://raw.githubusercontent.com/manikanta-anguluri/install-docker/main/install-docker-ubuntu.sh)
````

> 💡 Make sure you're running this as a user with `sudo` privileges.

## 📁 Files

* `install-docker-ubuntu.sh`: Main script for installing Docker and setting up access for all users.

## ⚠️ Security Notice

Adding users to the `docker` group grants them root-level privileges. Only trusted users should be allowed this access.

---

Feel free to fork or modify as needed.

````

---

### ✅ One-liner Command (as shown above)

```bash
bash <(curl -s https://raw.githubusercontent.com/manikanta-anguluri/install-docker/main/install-docker-ubuntu.sh)
````
