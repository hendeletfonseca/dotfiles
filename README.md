# arch-dotfiles

Personal post-install setup for Arch Linux — dotfiles, GNOME configuration, and automated provisioning via Ansible.

## Structure
```
.
├── ansible/          # Playbooks for automated setup
├── config/           # Personal config files (zsh, alacritty, etc.)
├── dotbot/           # Dotbot git submodule for symlinking config files
├── install           # Install dotfiles
├── install.conf.yaml # Dotbot config
└── setup.sh          # Pre-flight script to configure user permissions
```

## How it works

`setup.sh` runs first to ensure the user has the necessary permissions before Ansible takes over. After that, the Ansible playbooks provision the machine locally — installing packages, configuring GNOME, setting up Docker, ZSH, Flatpak apps, and symlinking dotfiles via Dotbot.

## Usage
```bash
# 1. Clone the repo
git clone --recurse-submodules https://github.com/hendeletfonseca/dotfiles.git

# 2. Run the pre-flight script
./setup.sh

# 3. Run the Ansible playbooks
cd ansible
ansible-playbook playbook.yml
```

## What gets configured

- **Locale & timezone** — `en_US.UTF-8`, `America/Sao_Paulo`
- **GNOME** — keyboard layout (ABNT2), keybindings, screen timeout, custom shortcuts
- **ZSH** — oh-my-zsh, zoxide, mise, syntax highlighting, autosuggestions
- **Docker** — packages, group, socket permissions, services
- **Flatpak** — Flathub remote and apps
- **Yay** — AUR helper
- **Dotfiles** — symlinked via Dotbot

## Roadmap

- [ ] Automate GNOME Shell extension installation via Ansible
- [ ] SET Copyous keybinding 
- [ ] Automate Dotbot run via Ansible