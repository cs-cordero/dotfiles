# Dotfiles

## Installation Instructions

### macOS Catalina 10.15.4 using [iTerm2](https://iterm2.com) and Zsh
```zsh
cd ${HOME}

# Pull in dotfiles from this repository
git init
git remote add origin https://github.com/cs-cordero/dotfiles.git
git pull origin master
git submodule update --init --recursive

# Install brew and associated brew casks
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install coreutils
brew install pyenv
brew install reattach-to-user-namespace
brew install ripgrep
brew install tmux
brew install vim
brew install neovim

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zshrc.pre-oh-my-zsh .zshrc
rm .zshrc.oh-my-zsh
echo 'export PYENV_ROOT="${HOME}/.pyenv"' > ${HOME}/.zsh-custom/pyenv.zsh
echo 'export PATH="${PYENV_ROOT}/bin:${PATH}"' >> ${HOME}/.zsh-custom/pyenv.zsh
echo 'eval "$(pyenv init -)"' >> ${HOME}/.zsh-custom/pyenv.zsh

# Install Python
# Restart the terminal so that pyenv gets init'd
pyenv install --list  # find the latest version
pyenv install x.y.z
pyenv global x.y.z
pip install --user black

# Configure iTerm2
Go to:  iTerm2 > Preferences > Keys > Presets... > Import... > keys.itermkeymap
Go to:  iTerm2 > Preferences > General > Selection > Applications in terinal may access clipboard
Go to:  iTerm2 > Preferences > Profiles > Text > Set Font
```


### macOS Mojave 10.14.5 using [iTerm2](https://www.iterm2.com/)
```bash
$ cd ~
$ git init
$ git remote add origin https://github.com/cs-cordero/dotfiles.git
$ git pull origin master
$ echo "source ~/.bashrc" > ~/.bash_profile  # use >> instead of > if you want to append
$ brew install reattach-to-user-namespace
$ brew install coreutils
$ source ~/.bashrc
$ git submodule update --init --recursive
$ # Update tmux key bindings for Cmd-i, Cmd-j, Cmd-k, Cmd-l (see below)
$
$ brew install pyenv
$ CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install [version]
$ pyenv global [version]
$
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
$ nvm install stable
$
$ brew install ripgrep
$ brew install vim
```

### Ubuntu 16.04 LTS
```bash
$ cd ~
$ rm .bashrc
$ git init
$ git remote add origin https://github.com/cs-cordero/dotfiles.git
$ git pull origin master
$ source ~/.bashrc
$ git submodule update --init --recursive
```


### Other Installation steps
* Preferred font is [**Hack**](https://sourcefoundry.org/hack/)
* Compile YouCompleteMe: https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64
    * If you do not want to compile YCM or would rather go without it, make sure you add 'youcompleteme' to the list of disabled packages at the top of the `.vimrc`.
* In order to get the pane-switching and pane-resizing functionality with Cmd+I,J,K,L and Cmd+↑,← ,↓,→ shortcuts, we need to use [iTerm2](https://www.iterm2.com/).  After installing and using iTerm2, go to Preferences > Keys and set the following mappings:
    * **You should just import this from the keys.itermkeymap file**
    * Cmd+i  -->  Send Hex Codes: 0x11
    * Cmd+j  -->  Send Hex Codes: 0x0e
    * Cmd+k  -->  Send Hex Codes: 0x17
    * Cmd+l  -->  Send Hex Codes: 0x13
    * Cmd+↑  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x41
    * Cmd+←  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x44
    * Cmd+↓  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x42
    * Cmd+→  -->  Send Hex Codes: 0x1b 0x1b 0x5b 0x43
* On Mac, if you are using third party peripherals, your keys could be all messed up and you need to fix it.
    * For your extra side mouse buttons, a tool called [SensibleSideButtons](http://sensible-side-buttons.archagon.net/) helps to make it just work.
    * For your keyboard's Home and End keys, create a file at `~/Library/KeyBindings/DefaultKeybinding.dict` (make the folder if necessary) and append the following text to it:
```
{
    /* Remap Home / End to be correct */
    "\UF729"  = moveToBeginningOfLine:;    // home
    "\UF72B"  = moveToEndOfLine:;          // end
    "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
    "$\UF72B" = moveToEndOfLineAndModifySelection:;       // shift-end
}
```

### Usage Notes
* Try to keep the `.bashrc` file completely clean and environment agnostic, i.e., don't add any directory aliases.
* Create and use a `.bash_aliases` file (not included in this repo and gitignored) for environment-specific bash settings.
* The included `.bashrc` already sources any `.bash_aliases` file if it exists.

### IntelliJ IDEA Exported Settings
The following settings are exported using the IntelliJ IDEA UI:
* Code Style (schemes)
* CodeInsight, Code Folding, DefaultFont, JavaCodeFoldingSettings
* Editor Colors
* File types
* Find
* General
* Key maps
* Key maps (schemes)
* MarkdownApplicationSettings
* VimKeySettings, VimEditorSettings, VimSettings

### Author
* Christopher Sabater Cordero: [Github](https://github.com/cs-cordero) | [LinkedIn](https://www.linkedin.com/in/cs-cordero/)


### Extra notes:
Install vim-plug
Need to install Node >= 12
Need to run :PlugInstall
Need to run :CocInstall coc-rust-analyzer
Need to run :CocInstall coc-json
Need to install Rust
Need to install gdb (with brew)
Neovim should be >= 0.5.0
export CXX=$(which clang++)
