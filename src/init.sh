function header() {
    clear
    cat <<-EOF
-------------------------------------------------------------------------------------------
        ${GREEN}⠀⠀⠀⠀⠀⡤⡄⠀⠀⠀⠀⠀⠀${RESET}   ${PURPLE}⠀⠀⠀⠀⠀⠀⢠⢤${RESET}
        ${GREEN}⠀⠀⢠⠻⣼⡄⡇⠀⠀⠀⠀⠀⠀${RESET}   ${PURPLE}⠀⠀⠀⠀⠀⠀⢸⢸⣧⠿⡄${RESET}
        ${GREEN}⠀⣀⢸⠀⢹⠁⢷⠀⠀⠀⠀⠀⠀${RESET}   ${PURPLE}⠀⠀⠀⠀⠀⠀⡾⠈⠇⠀⡇⣀${RESET}
        ${GREEN}⠀⣏⠛⡇⠀⡄⣸⡄⠀⠀⠀⠀⠀${RESET}   ${PURPLE}⠀⠀⠀⠀⠀⢠⣇⢰⢀⢸⠛⣹${RESET}
        ${GREEN}⠀⢹⡀⢡⠀⢁⠉⢳⡄⠀⠀⠀⠀${RESET}   ${PURPLE}⠀⠀⠀⠀⢠⡞⠈⡈⠀⡌⢀⡏⡀${RESET}      ${GREEN}Script Artixtect for Artix Linux${RESET}
        ${GREEN}⢹⡉⢣⠀⢂⠈⣆⢃⠙⢦⣀⠀⠀${RESET}   ${PURPLE}⠀⠀⣀⡴⠋⡘⣰⠁⡐⠀⡜⢉⡇${RESET}
        ${GREEN}⠀⠱⣄⠱⡃⠑⢏⠙⠂⠄⠈⠙⡆${RESET}   ${PURPLE}⢰⠋⠁⠠⠐⠃⡹⠊⢈⠌⣠⠎⠀${RESET}
        ${GREEN}⠈⠯⣍⠑⠄⡑⢟⠓⠤⠀⠂⠂⡇${RESET}   ${PURPLE}⢸⠐⠐⠀⠤⠚⡻⢊⠠⠊⣩⠽⠁${RESET}      ${PURPLE}GitHub : ${RESET}
        ${GREEN}⠀⠸⣏⠑⠢⢄⣩⠢⠤⠄⠀⠀⡇${RESET}   ${PURPLE}⢸⠀⠀⠠⠤⠔⣍⡠⠔⠊⣹⠇${RESET}
        ${GREEN}⠀⠀⠈⢛⣦⡄⠈⠢⢤⡤⠂⢀⣷${RESET}   ${PURPLE}⣾⡀⠐⢤⡤⠔⠁⢠⣴⡛⠁${RESET}
        ${GREEN}⠀⠀⠀⠈⠛⠲⠤⢤⣴⠏⣉⡴⠃${RESET}   ${PURPLE}⠘⢦⣉⠹⣦⡤⠤⠖⠛⠁${RESET}
        ${GREEN}⠀⠀⠀⠀⠀⠀⠀⠈⠛⠋⠁⠀⠀${RESET}   ${PURPLE}⠀⠀⠈⠙⠛⠁${RESET}
-------------------------------------------------------------------------------------------
EOF

    printf "${RED}This script will make changes to your system.${RESET}\n"
    printf "%b" "Some steps may take longer, depending on your Internet connection and CPU.\nPress ${GREEN}Enter${RESET} to continue, or ${RED}Ctrl+C${RESET} to cancel."

    read -rp "" choice
    [[ -n $choice ]] && exit 0
}