# Auto load functions (aka. make them available in the shell as bin commands)
export FPATH="$(pwd)/functions:$FPATH"
autoload load_pnpm load_nvmrc add-zsh-hook

# Setup load_nvmrc to be called on every directory change
add-zsh-hook chpwd load_nvmrc

# # If zsh-nvm omz plugin is installed, add the needed functions to the list of extra commands
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm ]; then
    export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvm_find_nvmrc' $NVM_LAZY_LOAD_EXTRA_COMMANDS[@])
fi
