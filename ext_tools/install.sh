#!/bin/bash

set -ex

INSTALL_DIR=/usr/local/bin
if [[ ! -w ${INSTALL_DIR} ]]; then
    INSTALL_DIR=${HOME}/.local/bin
    if [[ ! -d ${INSTALL_DIR} ]]; then
        mkdir -p ${INSTALL_DIR}
    fi
fi

# install iterm2 utilities
# docs: https://iterm2.com/documentation-utilities.html
function install_iterm2_utility() {
    TOOL=$1
    curl -fLo ${INSTALL_DIR}/${TOOL} https://iterm2.com/utilities/${TOOL}
    chmod +x ${INSTALL_DIR}/${TOOL}
}

install_iterm2_utility imgcat
install_iterm2_utility imgls
install_iterm2_utility it2check
install_iterm2_utility it2copy
install_iterm2_utility it2ul
install_iterm2_utility it2dl

# install bd
curl -fLo ${INSTALL_DIR}/bd https://raw.githubusercontent.com/vigneshwaranr/bd/master/bd
chmod +x ${INSTALL_DIR}/bd

