## Installation

    git clone git://github.com/acx0/bin.git ~/bin

Note: add ~/bin to the system's $PATH by adding the following to the
`~/.bashrc` or `~/.zshrc`:

    if [ -d "$HOME/bin" ]; then
        PATH="$HOME/bin:$PATH"
    fi
