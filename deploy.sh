#! /bin/bash
# Author: Jonathan Scott Villarreal
# Date: 10/2/2017
#
# Description: compile shell scripts into encrypted and encoded binaries
# Create Historical Versions of all your scripts
# Create Historical Versions of all your binaries
#
# Dependencies: shc
# Installation MacOS: brew install shc
# Installation Linux: sudo add-apt-repository ppa:neurobin/ppa
# Installation Linux: update
# Installation Linux: sudo apt install shc
#
# Add this paths to your bash_profile or zshrc
# export PATH="$HOME/The_Drive/bash_profile/production/bin:$PATH" >> ~/.bash_profile
# export PATH="$HOME/The_Drive/bash_profile/production/bin:$PATH" >> ~/.zshrc
#
# Source: https://github.com/neurobin/shc Author: neurobin
#
# Updated By Jonathan Scott Villarreal: 09/18/2021

    RED='\033[0;31m'
    PURPLE='\033[0;35m'
    YELLOW='\033[1;33m'
    ORANGE='\033[0;33m'
    CYAN='\033[1;36m'
    NC='\033[0m' # No Color

    # Making constant directories

    if [ ! -d $HOME/The_Drive/bash_profile/production/bin ]; then
         mkdir -p $HOME/The_Drive/bash_profile/production/bin
    fi

    if [ ! -d $HOME/The_Drive/bash_profile/production/backup_bin ]; then
         mkdir -p $HOME/The_Drive/bash_profile/production/backup_bin
    fi

    if [ ! -d $HOME/The_Drive/bash_profile/production/backup_scripts ]; then
         mkdir -p $HOME/The_Drive/bash_profile/production/backup_scripts
    fi

    if [ ! -d $HOME/The_Drive/bash_profile/dev/scripts ]; then
         mkdir -p $HOME/The_Drive/bash_profile/dev/scripts
    fi


    PRODUCTION_BIN=$HOME/The_Drive/bash_profile/production/bin
    PRODUCTION_BACKUP_BIN=$HOME/The_Drive/bash_profile/production/backup_bin
    PRODUCTION_BACKUP_SCRIPTS=$HOME/The_Drive/bash_profile/production/backup_scripts
    DEV_SCRIPTS=$HOME/The_Drive/bash_profile/dev/scripts

    PRODUCTION_BINARY_CHECK=$(ls -1 ${PRODUCTION_BIN} | wc -l)
    OUT_FILE_CLEANUP_CAT=$(ls -1 ${DEV_SCRIPTS} | grep ".sh.x.c" | wc -l)
    OUT_FILE_CLEANUP=$(ls -1 ${DEV_SCRIPTS} | grep ".sh.x.c")
    DEV_SCRIPTS_READ=$(ls -1 ${DEV_SCRIPTS} | awk -F '.' '{print $1}')
    DEV_SCRIPTS_CHECK=$(ls ${DEV_SCRIPTS} | sed '/.sh.x.c/d' | wc -l)

    printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
    printf "%s\n${CYAN}Performing A Binary Check${NC}"
    printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
    echo ""

        CLEANUP(){

            if [ "${OUT_FILE_CLEANUP_CAT}" -ge 1 ]; then
                echo "Cleaning up trailing binary files"
                    for i in ${OUT_FILE_CLEANUP}; do
                    echo "removing ${i}"
                    rm -f ${DEV_SCRIPTS}/"${i}"
                    done
                else
                echo "No trailing binary files were found. Continuing deployment..."

            fi
        }

        CLEANUP;

        echo ""
        printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
        printf "%s\n${CYAN}Creating Versioned Production Backup Scripts${NC}"
        printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
        echo ""
        if [ "${DEV_SCRIPTS_CHECK}" -ge 1 ]; then
            printf "%s\n${CYAN}Copying Dev Scripts To Production Backup Scripts${NC}"
            printf "%s\n${ORANGE}# of scripts being copied:${DEV_SCRIPTS_CHECK}${NC}"
            tar -czvf ${PRODUCTION_BACKUP_SCRIPTS}/production_scripts_"$(date +'%a-%h-%d-%Y-%I_%M_%S-%Z')".tar ${DEV_SCRIPTS} -C ${PRODUCTION_BACKUP_SCRIPTS}

        else [ "${DEV_SCRIPTS_CHECK}" -eq 0 ]
            printf "%s\n${ORANGE}# of scripts being copied:${DEV_SCRIPTS_CHECK}${NC}"
            printf "%s\n${ORANGE}You need to add your development scripts to the dev scripts directory to continue${NC}"
            printf "%s\n${ORANGE}Deployment Cannot Continue${NC}"
            exit 1;

        fi

        echo ""
        if [ "${PRODUCTION_BINARY_CHECK}" -ge 1 ]; then
            echo ""
            printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
            printf "%s\n${CYAN}Backing Up Current Production Binaries.${NC}"
            printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
            echo ""
                    tar -czvf ${PRODUCTION_BACKUP_BIN}/production_bin_"$(date +'%a-%h-%d-%Y-%I_%M_%S-%Z')".tar ${PRODUCTION_BIN} -C ${PRODUCTION_BACKUP_BIN}
            echo ""
            printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
            printf "%s\n${CYAN}# of Binaries that will be replaced: ${PRODUCTION_BINARY_CHECK}${NC}"
            printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
            echo ""

            for i in ${DEV_SCRIPTS_READ}; do
                printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
                printf "%s\n${ORANGE}Creating Binary For: "${i}".sh${NC}"
                printf "%s\n${PURPLE}Sending Binary to ${PRODUCTION_BIN}/"${i}"${NC}"
                echo ""
                sudo shc -f ${DEV_SCRIPTS}/"${i}".sh -o ${PRODUCTION_BIN}/"${i}"
                rm -f ${DEV_SCRIPTS}/"${i}.sh.x.c"
                printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
            done

            printf "%s\n${CYAN}Deployment is successful${NC}"

            else [ "${PRODUCTION_BINARY_CHECK}" -eq 0 ]
                echo ""
                printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
                printf "%s\n${CYAN}There are no binaries that will be replaced.${NC}"
                printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
                echo ""
                printf "%s\n${CYAN}Current Binary Count:${PRODUCTION_BINARY_CHECK}${NC}"
                printf "%s\n${CYAN}# of binaries will be created:${DEV_SCRIPTS_CHECK}${NC}"

                for i in ${DEV_SCRIPTS_READ}; do
                        echo ""
                        printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
                        printf "%s\n${CYAN}Creating Binary For: "${i}".sh${NC}"
                        printf "%s\n${CYAN}Sending Binary to ${PRODUCTION_BIN}/${i}${NC}"
                        sudo shc -f ${DEV_SCRIPTS}/"${i}".sh -o ${PRODUCTION_BIN}/"${i}"
                        printf "%s\n${PURPLE}--------------------------------------------------------------${NC}"
                done
            fi































