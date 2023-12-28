#!/bin/bash

usage() {
  tput setaf 7
  echo
  echo "Usage: $(basename $0) [-f] [-p <path>]"
  echo "  -f: force reinstall"
  echo "  -p <path>: install to <path>"
  tput sgr0
}

while getopts 'fp:h' opt; do
  case "$opt" in
    f) force=true ;;
    p) install_path="$OPTARG" ;;
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

package_name="$(tput setaf 2)extended-nvm-for-zsh$(tput sgr0)"

if [ -z "$install_path" ]; then
  if [ -z "$HOME" ]; then
    echo "HOME not found. Please set HOME environment variable and retry."
    exit 1
  fi

  install_path=$HOME/.zsh/extended-nvm-for-zsh

  # print install_path replacing $HOME with ~
  echo "Installing $package_name into $(tput setaf 4)$(echo $install_path | sed "s#$HOME#~#")$(tput sgr0)"
fi

if [ -d "$install_path" ]; then
  if ! [ $force ]; then
    echo "$package_name already installed. Use \`-f\` to force reinstall."
    echo "Or run \`rm -rf $install_path\` before retrying."
    exit 1
  fi

  echo "$(tput setaf 3)- Removing existing installation$(tput sgr0)"
  rm -rf $install_path
fi

mkdir -p "$(dirname $install_path)"

# Check if install script is being run from inside the repo
if [ -f "install.sh" ]; then
  echo "$(tput setaf 3)- Script is being run from inside the repo. Copying files instead of cloning.$(tput sgr0)"
  cp -r . $install_path
else
  git clone --depth 1 https://github.com/LiuBergaria/extended-nvm-for-zsh.git $install_path
fi

ZSHRC_PATH="$HOME/.zshrc"

if [ ! -f "$ZSHRC_PATH" ]; then
  echo "Creating ~/.zshrc"
  touch $ZSHRC_PATH
fi

init_command="source $install_path/init.zsh"

if grep -q "$init_command" "$ZSHRC_PATH"; then
  echo "$(tput setaf 3)- init already added to ~/.zshrc$(tput sgr0)"
else
  echo "Adding init to ~/.zshrc"
  printf '%s' "# Init extended-nvm-for-zsh
$init_command

$(cat $ZSHRC_PATH)" > $ZSHRC_PATH
fi

echo "$(tput setaf 2)Done!$(tput sgr0)"