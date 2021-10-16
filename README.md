# My neovim config

My neovim config might look messy at first but I like to keep my vim-config in just one file and organize it with fold-markers.

## .zshrc
Just copy the `.zshrc` file into your home directory. No `.oh-my-zsh` needed but I'm using `fzf`, `bat`, and `exa`. If you don't want to use either of them you might want to delete the functions and aliases.

### Features:
* Auto-completion enabled.
* `fd` let's you `cd` into a directory while using `fzf` to search for the folder/path. 
* `fh` let's you search in the command-history and use found command.
* `cat` comes with column-numbers and syntax-highlighting.
* Shows current git-branch and current node version in prompt.

# TODO
* [x] lua-fy neovim-configuration properly
* [ ] I'm thinking to reverte everything back to .vim. Lua-fying the configuration seems not to 
