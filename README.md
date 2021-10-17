# My config files

## Contains
* zsh (`.zshrc`)
* neovim (`init.lua`)
* (neo-)vim for vscode-extension (`vscode_init.vim`)
* colorscheme file for iterms (`iterm_toykonight_night.itermcolors`)
* tmux (`tmux.conf`) *needs to be rewritten*

My neovim config might look messy at first but I like to keep my vim-config in just one file and organize it with fold-markers.

### .zshrc
Just copy the `.zshrc` file into your home directory. No `.oh-my-zsh` needed but I'm using `fzf`, `bat`, and `exa`. If you don't want to use either of them you might want to delete the functions and aliases.

#### Features:
* Auto-completion enabled.
* `fd` let's you `cd` into a directory while using `fzf` to search for the folder/path. 
* `fh` let's you search in the command-history and use found command.
* `cat` comes with column-numbers and syntax-highlighting.
* Shows current git-branch and current node version in prompt.

### Neovim
#### Language-Server:
You have to install the following language-server:
* `npm i -g bash-language-server`
* `npm i -g vscode-langservers-extracted`
* `npm i -g dockerfile-language-server-nodejs`
* `npm i -g dot-language-server`
* `npm i -g emmet-ls`
* `npm i -g graphql-language-service-cli`
* `npm i -g svelte-language-server`
* `npm i -g typescript typescript-language-server`
* `npm i -g vim-language-server`
* `npm i -g @volar/server`
* `npm i -g vls`

`npm i -g bash-language-server vscode-langservers-extracted dockerfile-language-server-nodejs dot-language-server emmet-ls graphql-language-service-cli svelte-language-server typescript typescript-language-server vim-language-server @volar/server vls`

#### Tree-Sitter
You might want to install the following parser:
`:TSInstall html css scss javascript typescript vue svelte`

## TODO
* [x] lua-fy neovim-configuration properly
* [ ] I'm thinking to revert everything back to a .vim file. Lua-fying the configuration seems not to improve anything. It's just more verbose.
