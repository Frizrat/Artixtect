source src/cmd.sh

function install_aur() {
    
    exec_log "sudo pacman -S --noconfirm --needed git" "Installing git"

    local choice=""

    while [[ ! $choice =~ ^(yay|paru)$ ]]; do
        read -rp "Which aur helper do you want to install ? (yay/paru) : " choice
        choice="${choice,,}"
    done
    echo -e "${GREEN}You chose ${choice}${RESET}"

    export AUR=$choice

    local bin=""
    read -rp "Would you want to compile it ? ${RED}(might be long)${RESET} (Y/n) : " choice
    choice="${choice,,}"

    if [[ $choice =~ ^(no|n)$ ]]; then
        bin="-bin"
    fi

    if ! pacman -Qi "${AUR}" &>/dev/null; then
        exec_log "git clone https://aur.archlinux.org/$AUR$bin.git" "Cloning $AUR$bin"
        cd "$AUR$bin" || return 1
        exec_log "makepkg -si --noconfirm" "Installing ${AUR}"
        cd .. || return 1
        exec_log "rm -rf $AUR$bin" "Deleting directory $AUR$bin"
    fi

    if [[ $AUR == "yay" ]]; then
        exec "yay -Y --gendb" "Configuring ${AUR}"
        exec "yay -Y --devel --save" "Configuring ${AUR}"
        exec_log "sed -i 's/\"sudoloop\": false,/\"sudoloop\": true,/' ~/.config/yay/config.json" "Enabling SudoLoop option for yay"
    elif [[ $AUR == "paru" ]]; then
        exec "paru --gendb" "Configuring ${AUR}"
        exec_log "sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf" "Enabling BottomUp option for paru"
        exec_log "sudo sed -i 's/#SudoLoop/SudoLoop/' /etc/paru.conf" "Enabling SudoLoop option for paru"
        exec_log "sudo sed -i 's/#CombinedUpgrade/CombinedUpgrade/' /etc/paru.conf" "Enabling CombinedUpgrade option for paru"
        exec_log "sudo sed -i 's/#UpgradeMenu/UpgradeMenu/' /etc/paru.conf" "Enabling UpgradeMenu option for paru"
        exec_log "sudo sed -i 's/#NewsOnUpgrade/NewsOnUpgrade/' /etc/paru.conf" "Enabling NewsOnUpgrade option for paru"
        exec_log "sudo sh -c 'echo "SkipReview" >> /etc/paru.conf'" "Enabling SkipReview option for paru"
    fi
}