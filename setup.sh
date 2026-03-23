#!/bin/bash
# Arch Linux Post-Installation Setup - Initial Configuration

set -e

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "Error: This script must not be run as root" >&2
   exit 1
fi

echo "Setting up Arch Linux post-installation environment..."
echo ""

# Configure sudoers for NOPASSWD
echo "Configuring sudoers..."
SUDOERS_FILE="/etc/sudoers.d/ansible"

if [ -f "$SUDOERS_FILE" ]; then
    echo "Warning: $SUDOERS_FILE already exists"
    read -p "Overwrite? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping sudoers configuration"
    else
        echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee "$SUDOERS_FILE" > /dev/null
        sudo chmod 440 "$SUDOERS_FILE"
    fi
else
    echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee "$SUDOERS_FILE" > /dev/null
    sudo chmod 440 "$SUDOERS_FILE"
fi

# Check Ansible installation
echo "Checking Ansible..."
if ! command -v ansible &> /dev/null; then
    echo "Installing Ansible..."
    sudo pacman -S --noconfirm ansible git python
else
    ANSIBLE_VERSION=$(ansible --version | head -n 1)
    echo "Ansible already installed: $ANSIBLE_VERSION"
fi

# Install Ansible collections
echo "Installing Ansible collections..."
cd "$(dirname "$0")/ansible"

if [ -f "requirements.yml" ]; then
    ansible-galaxy collection install -r requirements.yml
else
    echo "Error: requirements.yml not found" >&2
    exit 1
fi

# Cleanup and summary
echo ""
echo "Setup complete."
echo ""
echo "Next steps:"
echo "1. Review config: ansible/config.yml"
echo "2. Test: ansible-playbook ansible/playbook.yml --check"
echo "3. Run: ansible-playbook ansible/playbook.yml"
echo ""

