source src/cmd.sh

function sound_server() {
    local choice=""

    while [[ ! $choice =~ ^(pulseaudio|pipewire)$ ]]; do
        read -rp "Which sound server do you want to install ? (pulseaudio/pipewire) : " choice
        choice="${choice,,}"
    done

    echo -e "${GREEN}You chose ${choice}${RESET}"

    local inlst="$choice $choice-jack "
    if [[ $choice == "pulseaudio" ]] then
        inlst+=" pulseaudio-equalizer "
    else
        inlst="
            pipewire-$INIT
            wireplumber
            pipewire-pulse
            pipewire-pulse-$INIT
        "
    fi
    export SOUND=$choice

    read -rp "Do you want to install Alsa packages ? (y/N) : " choice
    choice="${choice,,}"

    if [[ $choice =~ ^(yes|y)$ ]]; then
        inlst+="
            alsa-utils
            alsa-utils-$INIT
            alsa-plugins
            alsa-firmware
            alsa-ucm-conf
            sof-firmware
            $SOUND-alsa
        "

        if [[ $SOUND == "pulseaudio" ]] then
            inlst+=" apulse"
        fi
    fi
    install_lst "${inlst}"
}

function firewall() {
    read -rp "Do you want to install a firewall /!\ Install and activate firewalld? The default configuration may block access to printers and other devices on your local network ? (y/N) : " choice
    choice="${choice,,}"

    if [[ $choice =~ ^(yes|y)$ ]]; then
        install_lst "firewalld firewalld-$INIT python-pyqt5 python-capng"
        # exec_log "sudo systemctl enable --now firewalld.service" "Enabling firewalld"
    fi
}