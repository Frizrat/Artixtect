source src/cmd.sh

function config_pacman() {
    exec_log "sudo sed -i 's/#Color/Color/' /etc/pacman.conf" "Enabling color in pacman"
    exec_log "sudo sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf" "Enabling verbose package lists in pacman"
    exec_log "sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf" "Enabling parallel downloads in pacman"
    exec_log "sudo sed -i 's/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf" "Enabling multithread compilation"
}

function add_arch_repositories() {
    exec_log "sudo pacman -S --noconfirm artix-archlinux-support" "Downloading Arch Support"
    exec_log "wget 'https://archlinux.org/mirrorlist/?country=all&protocol=https' -O /etc/pacman.d/mirrorlist-arch" "Downloading Arch mirrorlist"
    exec_log "sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist-arch" "Enabling server arch"
    exec_log "sudo printf '\n## Arch\n[extra]\nInclude = /etc/pacman.d/mirrorlist-arch\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist-arch' >> /etc/pacman.conf" "Adding Arch repositories"
    exec_log "sudo pacman-key --populate archlinux" "Adding Arch key"
}

function mirrorlist() {
    exec_log "sudo pacman -S --noconfirm pacman-contrib" "Downloading Pacman contrib"
    exec_log "sudo curl -s 'https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist' | sed 's/#Server/Server/' | rankmirrors -n 5 - | tee /etc/pacman.d/mirrorlist && sudo sed -i '/^#/d' /etc/pacman.d/mirrorlist" "Updating Artix mirrorlist ${RED}(might be long)${RESET}"
    exec_log "sudo curl -s 'https://archlinux.org/mirrorlist/?country=all&protocol=https' | sed 's/#Server/Server/' | rankmirrors -n 5 - | tee /etc/pacman.d/mirrorlist-arch && sudo sed -i '/^#/d' /etc/pacman.d/mirrorlist-arch" "Updating Arch mirrorlist ${RED}(might be long)${RESET}"
    exec_log "sudo pacman -Syyu --noconfirm" "Updating full system ${RED}(might be long)${RESET}"
}