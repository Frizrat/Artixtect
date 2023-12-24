source src/cmd.sh
source src/system/drivers/nvidia.sh
source src/system/drivers/amd.sh
source src/system/drivers/intel.sh
source src/system/drivers/vm.sh

function video_drivers() {
    local choice=""
    while [[ ! $choice =~ ^(amd|intel|nvidia|vm)$ ]]; do
        read -rp "What is your graphics card type ? (amd/intel/nvidia/vm) : " choice
        choice="${choice,,}"
    done

    echo -e "${GREEN}You chose ${choice}${RESET}"
    case "${choice}" in
    "amd") amd_drivers;;
    "intel") intel_drivers;;
    "nvidia") nvidia_drivers;;
    "vm") vm_drivers;;
    esac
}