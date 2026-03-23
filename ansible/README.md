# Arch Linux Post-Installation Setup (Automated with Ansible)

Automatização simples e clara para configurar Arch Linux do zero. Tudo centralizado em um arquivo de configuração.

## Estrutura

```
ansible/
├── playbook.yml              # Orquestração principal
├── config.yml                # ⭐ ARQUIVO ÚNICO COM TODAS AS CONFIGS
├── tasks/                    # Tasks separadas
│   ├── yay.yml
│   ├── hardware.yml          # AMD CPU + NVIDIA GPU drivers
│   ├── multimedia.yml
│   ├── zsh.yml
│   ├── terminal_tools.yml
│   ├── docker.yml
│   ├── applications.yml
│   └── flatpak.yml
├── ansible.cfg               # Configuração do Ansible
├── inventory.ini             # Localhost
└── README.md
```

## Quick Start

### 1. Instalar Ansible (na VM)

```bash
sudo pacman -Syu
sudo pacman -S ansible git python
```

### 2. Clonar/copiar o repositório

```bash
cd ~
git clone https://github.com/seu-usuario/arch-setup.git
cd arch-setup/ansible
```

### 3. Revisar configurações (opcional)

É tudo centralizado em `config.yml` - customize apenas aí:

```bash
nano config.yml
```

**Flags de features:**
```yaml
install_yay: true                    # Instalar YAY
install_hardware_config: true        # AMD CPU + NVIDIA GPU drivers
install_multimedia: true             # Pacotes multimedia
install_zsh: true                    # ZSH + plugins
install_terminal_tools: false        # Utilitários de terminal
install_docker: true                 # Docker
install_applications: true           # Chrome, Firefox, VS Code
install_flatpak: true                # Flatpak apps
```

### 4. Instalar collections

```bash
ansible-galaxy collection install -r requirements.yml
```

### 5. Executar

```bash
ansible-playbook playbook.yml
```

Pede senha sudo automaticamente quando necessario.

## Teste (Dry-run)

Ver o que seria instalado SEM fazer nada:

```bash
ansible-playbook playbook.yml --check
```

## Desabilitar Features

Customize via CLI:

```bash
# Pular Docker
ansible-playbook playbook.yml -e "install_docker=false"

# Pular múltiplas
ansible-playbook playbook.yml -e "install_docker=false" -e "install_flatpak=false"
```

Ou edite `config.yml` diretamente.

## Customização

Tudo está em **`config.yml`**:

- **install_X:** Feature flags (true/false)
- **multimedia_pacman_packages:** Lista de pacotes multimedia
- **zsh_config:** Configurações do ZSH
- **docker_config:** Settings do Docker
- **flatpak_apps:** Apps Flatpak a instalar
- E mais...

Exemplo - mudar lista de packages:

```yaml
terminal_tools_packages:
  - alacritty
  - neovim
  - fzf           # ← adicione aqui
  - ripgrep
```

## O que Instala

| Feature | Descrição | Arquivo |
|---------|-----------|---------|
| Hardware | AMD CPU (amd-ucode) + NVIDIA GPU drivers & CUDA | `tasks/hardware.yml` |
| Multimedia | Codecs, GStreamer, ffmpeg, vlc | `tasks/multimedia.yml` |
| ZSH | Shell + oh-my-zsh + plugins + mise + zoxide | `tasks/zsh.yml` |
| Terminal Tools | alacritty, neovim, fzf, ripgrep, fd, bat, exa, btop, etc | `tasks/terminal_tools.yml` |
| Docker | Container engine + lazydocker + group setup | `tasks/docker.yml` |
| Applications | Google Chrome, Firefox, VS Code | `tasks/applications.yml` |
| Flatpak | OBS, Spotify, Brave, Telegram, Xournal++, etc (14 apps) | `tasks/flatpak.yml` |
Após executar o playbook:

### 1. **ZSH Default Shell**
```bash
exit  # Logout
# Login novamente
echo $SHELL  # Deve ser /bin/zsh
```

### 2. **Docker Group**
```bash
exit  # Logout
# Login novamente
docker ps  # Deve funcionar sem sudo
```

Ou apply imediatamente:
```bash
newgrp docker
```

### 3. **Audio (Opcional)**
Se precisar configurar auto-mute do headset:
```bash
aplay -l  # Listar dispositivos
am`bash
# Pacotes instalados
yay -Q | wc -l

# ZSH
echo $SHELL

# Plugins ZSH
ls ~/.oh-my-zsh/custom/plugins/

# Docker
docker ps

# Flatpak apps
flatpak list --app | wc -l
```

## Troubleshooting

### Erro: `ansible_become_password undefined`
✅ Já corrigido - removemos essa linha

### Erro: `become_ask_pass = False`
✅ Já corrigido - mudamos para `True` em `ansible.cfg`

### Erro: `flatpak remote_url not supported`
✅ Já corrigido - usando `flatpak remote-add` via shell

### YAY build falha
- Deixe terminar, pode levar 5-10 min
- Check `/tmp/yay/` para debug

### "sudo password was required"
Rode novamente com `ansible-playbook playbook.yml` - pede senha automaticamente

## Dotfiles Integration

Esse Ansible NÃO gerencia dotfiles (.zshrc, alacritty.toml, etc). Continue usando seu dotbot repo:

```bash
cd ~/path/to/dotfiles
./install  # Seu comando dotbot
```

## Estrutura Simples

**Por quê essa arquitetura?**
- ✅ Sem `roles/*/defaults` - tudo em um lugar
- ✅ Sem `roles/*/handlers` - tasks são diretas
- ✅ Um arquivo `config.yml` - customize tudo ali
- ✅ Tasks separadas - fácil de encontrar e debugar
- ✅ Claro e manutenível

## Próximos passos

1. Customize `config.yml` se necessário
2. Rode `ansible-playbook playbook.yml`
