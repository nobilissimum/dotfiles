source ~/.shrc/utils/common.sh



bak () {
    if [ ! -d "${BAKDIR}" ]; then
        echo -e "${BLUE}Creating directory ${BAKDIR}"
        command mkdir -- "${BAKDIR}"
    fi

    for key in "${(@k)bakpaths[@]}"; do
        if [[ ! -d "$key" && ! -s "$key"  ]]; then
            echo -e "${RED}No directory or file ${BOLD_RED}${key}${RESET}${RED} exists. Skipping...${RESET}"
            continue
        fi

        echo -e "${YELLOW}Creating backup for ${BOLD_YELLOW}${key}"
        bakpath "$key"
    done
}
