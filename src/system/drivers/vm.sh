source src/cmd.sh

function vm_drivers() {
    install_one "virt-what"

    local -r vm="$(sudo virt-what)"

    local -r inlst_all="
        vulkan-swrast
        lib32-vulkan-swrast
    "

    install_lst "${inlst_all}"

    if [[ ${vm} =~ (^|[[:space:]])virtualbox($|[[:space:]]) ]]; then
        install_one "virtualbox-guest-utils"
        # exec_log "sudo systemctl enable --now vboxservice" "activation of vboxservice"
        exec_log "sudo VBoxClient-all" "activation of VBoxClient-all"
    else
        install_lst "spice-vdagent qemu-guest-agent"
    fi

    uninstall_one "virt-what"
}