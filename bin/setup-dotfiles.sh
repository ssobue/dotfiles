#!/usr/bin/env bash

CHECKOUT_DIR=~/src
CHECKOUT_REPOSITORY="dotfiles"

function link_file() {
  ORIG_FILE=$1
  TARGET_FILE=$2
  # backup exist file
  if [[ -f "${TARGET_FILE}" -o -h "${TARGET_FILE}" ]]; then
    mv -fv "${TARGET_FILE}" "${TARGET_FILE}.bak"
  fi

  ln -s "${ORIG_FILE}" "${TARGET_FILE}"
}

function setup_clone_dir() {
  if [[ ! -d "${CHECKOUT_DIR}" ]]; then
    mkdir "${CHECKOUT_DIR}"
  fi

  cd "${CHECKOUT_DIR}"

  for REPO in ${CHECKOUT_REPOSITORY}; do
    if [[ ! -d "${REPO}" ]]; then
      git clone https://github.com/meru26/${REPO}.git
    fi
  done
}

function setup_mac_setting() {
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_profile .bash_profile
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bashrc.mac .bashrc
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_env.mac .bash_env
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_alias.bsd .bash_alias
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_color .bash_color
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_function .bash_function
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_sharehistory .bash_sharehistory
  link_file ${CHECKOUT_DIR}/dotfiles/etc/gitconfig .gitconfig
  link_file ${CHECKOUT_DIR}/dotfiles/etc/tmux.conf .tmux.conf
  link_file ${CHECKOUT_DIR}/dotfiles/etc/vimrc .vimrc
}

function setup_linux_setting() {
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_profile .bash_profile
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bashrc.linux .bashrc
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_env.linux .bash_env
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_alias.gnu .bash_alias
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_color .bash_color
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_function .bash_function
  link_file ${CHECKOUT_DIR}/dotfiles/etc/bash_sharehistory .bash_sharehistory
  link_file ${CHECKOUT_DIR}/dotfiles/etc/vimrc .vimrc
}

# check git command
if [[ ! -x /usr/bin/git -a ! -x /usr/local/bin/git ]]; then
  exit 1
fi

# choose architecture
if [[ "$(uname)" = "Linux" ]]; then
  setup_clone_dir
  setup_linux_setting
elif [[ "$(uname)" = "Darwin" ]]; then
  setup_clone_dir
  setup_mac_setting
else
  exit 2
fi
