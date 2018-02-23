# Dotfiles

### Installation Instructions
  * Ubuntu 16.04 LTS
  ```
  $ cd ~
  $ rm .bashrc
  $ git init
  $ git remote add origin https://github.com/cs-cordero/dotfiles.git
  $ git pull origin master
  $ source ~/.bashrc
  $ git submodule update --init --recursive
  ```

  * macOS Sierra 10.12.6 using [iTerm2](https://www.iterm2.com/)
  ```
  $ cd ~
  $ git init
  $ git remote add origin https://github.com/cs-cordero/dotfiles.git
  $ git pull origin master
  $ echo "source ~/.bashrc" > ~/.bash_profile  # use >> instead of > if you want to append
  $ brew install reattach-to-user-namespace
  $ brew install coreutils
  $ source ~/.bashrc
  $ git submodule update --init --recursive
  # Update tmux key bindings for Cmd-i, Cmd-j, Cmd-k, Cmd-l (see below)
  ```

### Other Installation steps
  * Install `Node` and `npm`: https://nodejs.org/en/download/package-manager/
  * Compile YouCompleteMe: https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64
    * If you do not want to compile YCM or would rather go without it, make sure you add 'youcompleteme' to the list of disabled packages at the top of the `.vimrc`.
  * In order to get the pane-switching and pane-resizing functionality with Cmd+I,J,K,L and Cmd+↑,← ,↓,→ shortcuts, we need to use [iTerm2](https://www.iterm2.com/).  After installing and using iTerm2, go to Preferences > Keys and set the following mappings:

  * Cmd-i  -->  Send Hex Codes: 0x11
  * Cmd-j  -->  Send Hex Codes: 0x01
  * Cmd-k  -->  Send Hex Codes: 0x17
  * Cmd-l  -->  Send Hex Codes: 0x13
  * Cmd-↑  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x41
  * Cmd-←  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x44
  * Cmd-↓  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x42
  * Cmd-→  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x43

### Usage Notes
  * Try to keep the `.bashrc` file completely clean and environment agnostic, i.e., don't add any directory aliases.
  * Create and use a `.bash_aliases` file (not included in this repo and gitignored) for environment-specific bash settings.
  * The included `.bashrc` already sources any `.bash_aliases` file if it exists.

### Author
  * Christopher Sabater Cordero: [Github](https://github.com/cs-cordero) | [LinkedIn](https://www.linkedin.com/in/cs-cordero/)