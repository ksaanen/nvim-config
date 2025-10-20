# nvim-config

## Installation

### Windows
For Windows it's easiest to install WSL (Windows Subsystem for Linux) and follow the Linux instructions below.

### Linux
To install Neovim on Linux, you can use the following commands to download and extract the latest release:
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
```

Then add this to your shell config (~/.bashrc, ~/.zshrc, ...):
```export PATH="$PATH:/opt/nvim-linux-x86_64/bin"```

### Install external dependencies
- Install Git, Make, Unzip ```sudo apt install git make unzip gcc```
- Install Ripgrep ```sudo apt install ripgrep```
- Install Build Tools ```sudo apt install build-essential```
- Install CMake ```sudo apt install cmake```

## Features
- Native LSP (https://github.com/neovim/nvim-lspconfig)
- Telescope (https://github.com/nvim-telescope/telescope.nvim)

## Language support
- Lua
- Rust
- TypeScript
- Angular

### Additional steps needed for language support
- Install NodeJS (https://nodejs.org/en/download/)
- Install TypeScript and tsserver by running ```npm install -g typescript typescript-language-server```
- Install Angular Language Service by running ```npm install -g @angular/language-service```
    - Make sure to install the Angular Language Service in your global npm packages at the same version as the project is using.
- Install Lua Language Server (https://luals.github.io/#neovim-install)
- Install Rust toolchain (https://www.rust-lang.org/)
- Install Rust Analyzer by running ```rustup component add rust-analyzer```

## Usage
Have a look at the cheatsheet.md or run ```:help cheatsheet``` inside Neovim for a quick reference of commands and features.

