# Dotfiles

### Installation Instructions
  * Confirmed on Ubuntu 16.04 LTS
  ```
  $ cd ~
  $ rm .bashrc
  $ git init
  $ git remote add origin https://github.com/cs-cordero/dotfiles.git
  $ git pull origin master
  $ source ~/.bashrc
  $ git submodule update --init --recursive
  ```
  
### Other Installation steps
  * Install `Node` and `npm`: https://nodejs.org/en/download/package-manager/
  * Compile YouCompleteMe: https://valloric.github.io/YouCompleteMe/#ubuntu-linux-x64
    * If you do not want to compile YCM or would rather go without it, make sure you add 'youcompleteme' to the list of disabled packages at the top of the `.vimrc`.
    
### Usage Notes
  * Try to keep the `.bashrc` file completely clean and environment agnostic, i.e., don't add any directory aliases.
  * Create and use a `.bash_aliases` file (not included in this repo and gitignored) for environment-specific bash settings.
  * The included `.bashrc` already sources any `.bash_aliases` file if it exists.
  
### Author
  * Christopher Sabater Cordero: [Github](https://github.com/cs-cordero) | [LinkedIn](https://www.linkedin.com/in/cs-cordero/)
