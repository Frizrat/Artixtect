function detect_init_system() {
    local init=$(realpath /sbin/init)

    if [[ $init =~ "dinit" ]]; then
        export INIT=dinit
    elif [[ $init =~ "openrc" ]]; then
        export INIT=openrc
    elif [[ $init =~ "runit" ]]; then
        export INIT=runit
    elif [[ $init =~ "s6" ]]; then
        export INIT=s6
    else 
        echo -e "${RED}Error: No Init system detected${RESET}"
        return 1
    fi;
    return 0;
}