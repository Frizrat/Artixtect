function check_internet() {
    local -r tool='curl'
    local -r tool_opts='-s --connect-timeout 8'

    if ! ${tool} ${tool_opts} https://artixlinux.org/ >/dev/null 2>&1; then
        echo -e "${RED}Error: No Internet connection${RESET}"
        return 1
    fi

    return 0
}