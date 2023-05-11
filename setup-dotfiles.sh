#!/usr/bin/env bash

CHECKOUT_DIR="${HOME}/src"
CHECKOUT_REPOSITORY="dotfiles"

function link_file() {
  ORIG_FILE=$1
  TARGET_FILE=$2
  # backup exist file
  if [[ -f "${TARGET_FILE}" || -h "${TARGET_FILE}" ]]; then
    mv -fv "${TARGET_FILE}" "${TARGET_FILE}.bak"
  fi

  ln -s "${ORIG_FILE}" "${TARGET_FILE}"
}

function setup_clone_dir() {
  if [[ ! -d "${CHECKOUT_DIR}" ]]; then
    mkdir "${CHECKOUT_DIR}"
  fi

  # shellcheck disable=SC2164
  cd "${CHECKOUT_DIR}"

  for REPO in ${CHECKOUT_REPOSITORY}; do
    if [[ ! -d "${REPO}" ]]; then
      git clone "https://github.com/ssobue/${REPO}.git"
    fi
  done
}

function setup_mac_setting() {
  link_file "${CHECKOUT_DIR}/dotfiles/zshenv.mac" "${HOME}/.zshenv"
  link_file "${CHECKOUT_DIR}/dotfiles/zshrc.mac"  "${HOME}/.zshrc"
  link_file "${CHECKOUT_DIR}/dotfiles/gitconfig"  "${HOME}/.gitconfig"
  link_file "${CHECKOUT_DIR}/dotfiles/vimrc"      "${HOME}/.vimrc"
}

function setup_linux_setting() {
  link_file "${CHECKOUT_DIR}/dotfiles/zshenv.linux" "${HOME}/.zshenv"
  link_file "${CHECKOUT_DIR}/dotfiles/zshrc.linux"  "${HOME}/.zshrc"
  link_file "${CHECKOUT_DIR}/dotfiles/gitconfig"    "${HOME}/.gitconfig"
  link_file "${CHECKOUT_DIR}/dotfiles/vimrc"        "${HOME}/.vimrc"
}

# check git command
if [[ ! -x /usr/bin/git && ! -x /usr/local/bin/git ]]; then
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
