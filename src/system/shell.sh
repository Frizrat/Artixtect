source src/cmd.sh

function shell_config() {
    local -r config_file=(
        "${HOME}/.bashrc"
        "${HOME}/.zshrc"
        "${HOME}/.config/fish/config.fish"
    )
    local alias=(
        "alias fix-key='sudo rm /var/lib/pacman/sync/* && sudo rm -rf /etc/pacman.d/gnupg/* && sudo pacman-key --init && sudo pacman-key --populate && sudo pacman -Sy --noconfirm artix-keyring archlinux-keyring && sudo pacman --noconfirm -Su'"
        "alias update-artix='${AUR} && flatpak update'"
        # "alias update-mirrors-artix='sudo curl -s 'https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist' | sed 's/#Server/Server/' | rankmirrors -n 5 - | tee /etc/pacman.d/mirrorlist && sudo sed -i '/^#/d' /etc/pacman.d/mirrorlist && sudo pacman -Syyu'"
        # "alias update-mirrors-arch='sudo curl -s 'https://archlinux.org/mirrorlist/?country=all&protocol=https' | sed 's/#Server/Server/' | rankmirrors -n 5 - | tee /etc/pacman.d/mirrorlist-arch && sudo sed -i '/^#/d' /etc/pacman.d/mirrorlist-arch && && sudo pacman -Syyu'"
        # "alias update-mirrors=update-mirrors-artix && update-mirrors-arch"
    )

    if [[ ${AUR} == yay ]]; then
        alias+=("alias clean-artix='yay -Sc && yay -Yc && flatpak remove --unused'")
    elif [[ ${AUR} == paru ]]; then
        alias+=("alias clean-artix='paru -Sc && paru -c && flatpak remove --unused'")
    fi

    local index=0
    local choice=""

    while [[ ! $choice =~ ^(bash|fish)$ ]]; do
        read -rp "What is your default shell ? (bash/fish) : " choice
        choice="${choice,,}"
    done

    echo -e "${GREEN}You chose ${choice}${RESET}"
    case $choice in
    bash) touch "${HOME}/.bashrc";;
    fish)
        install_one "fish"

        local current_shell=$(getent passwd $USER | cut -d: -f7)

        while [ "$current_shell" != "/usr/bin/fish" ]; do
            echo "Changement du shell par défaut en fish..."
            chsh -s "/usr/bin/fish"
            current_shell=$(getent passwd $USER | cut -d: -f7)
        done

        fish -c 'fish_update_completions'
        fish -c 'set -U fish_greeting'
        mkdir -p "${HOME}/.config/fish"
        touch "${HOME}/.config/fish/config.fish"
        index=2;;
    esac

    if [[ $index -ne 3 ]]; then
        for i in "${alias[@]}"; do
            if ! grep -q "${i}" "${config_file[$index]}"; then
                echo "${i}" >>"${config_file[$index]}"
            fi
        done
    fi
}