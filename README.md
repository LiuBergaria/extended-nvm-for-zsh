## Extended NVM for ZSH

Two simple zsh functions to load node version from .nvmrc and install pnpm if it's not installed for that version. The load_nvmrc is based on the original [load-nvmrc](https://github.com/nvm-sh/nvm?tab=readme-ov-file#zsh).

### Installation

```sh
curl -o- https://raw.githubusercontent.com/LiuBergaria/extended-nvm-for-zsh/master/install.sh | bash
```

### Usage

Whenever you enter a directory with a .nvmrc file, the node and corresponding pnpm version will be loaded or installed.
