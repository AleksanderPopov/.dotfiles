#!/usr/bin/env bash

DPATH=$HOME/.dotfiles

function main() {

  [ ! -d $HOME/.dotfiles ] && git clone https://github.com/aleksanderpopov/.dotfiles.git $HOME/.dotfiles
  cd $HOME/.dotfiles

  managers
  langs
  software
  terminal
  neovim
  link_configs

  sudo -v
  chmod +x ./macos.sh && ./macos.sh

}

function managers() {

  touch $HOME/.bash_profile

  echo "+-----------------------------------+"
  echo "|        Installing Homebrew        |"
  echo "+-----------------------------------+"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/cask

  echo "+-------------------------------+"
  echo "|        Installing asdf        |"
  echo "+-------------------------------+"
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf
  cd $HOME/.asdf || exit
  git checkout "$(git describe --abbrev=0 --tags)"
  cd -- || exit

}

function langs() {
  echo "+---------------------------------+"
  echo "|        Installing NodeJS        |"
  echo "+---------------------------------+"
  brew install coreutils
  brew install gpg
  asdf plugin-add nodejs
  bash $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 13.6.0
  asdf global nodejs 13.6.0
  asdf plugin-add yarn
  asdf install yarn 1.21.1
  asdf global yarn 1.21.1

  echo "+-------------------------------+"
  echo "|        Installing Java        |"
  echo "+-------------------------------+"
  asdf plugin-add java
  asdf install java adopt-openjdk-8u232-b09_openj9-0.17.0
  asdf global java adopt-openjdk-8u232-b09_openj9-0.17.0
  asdf plugin-add gradle
  asdf install gradle 6.1-milestone-3
  asdf global gradle 6.1-milestone-3

  echo "+---------------------------------+"
  echo "|        Installing Python        |"
  echo "+---------------------------------+"
  asdf plugin-add python
  asdf install python 3.8.1
  asdf install python 2.7.13
  asdf global python 2.7.13 3.8.1

  echo "+-------------------------------+"
  echo "|        Installing Ruby        |"
  echo "+-------------------------------+"
  asdf plugin-add ruby
  asdf install ruby 2.7.0
  asdf global ruby 2.7.0

  asdf reshim
}

function software() {

  echo "+-----------------------------------+"
  echo "|        Installing Software        |"
  echo "+-----------------------------------+"

  brew install htop \
    tig \
    watch \
    grep \
    openssh \
    rsync \
    # for alfred lastpass workflow
    lastpass-cli \
    ssh-copy-id \
    bat \
    prettyping \
    mas \
    the_silver_searcher ripgrep

  gem install colorls

  brew cask install \
    google-chrome firefox \
    alfred \
    transmission \
    the-unarchiver \
    macs-fan-control \
    dropbox \
    steam \
    docker \
    telegram skype zoom \
    vlc \
    tunnelblick \
    flux \
    toggl \
    blockblock \
    teamviewer \
    ledger-live \
    vanilla \
    arduino \
    boom-3d \
    karabiner-elements \
    intellij-idea-ce \
    expressvpn


  mas lucky Magnet
  mas lucky Clocker
  mas lucky Keynote
  mas lucky Pages

}

function terminal() {

  echo "+-----------------------------------+"
  echo "|        Installing Terminal        |"
  echo "+-----------------------------------+"

  brew tap caskroom/fonts
  brew cask install iterm2 font-hack-nerd-font font-fira-code

  # link iterm2 profile
  ITERM_PROFILES_PATH="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  mkdir -p "$ITERM_PROFILES_PATH"
  ln -fvs $DPATH/terminal/profile.json "$ITERM_PROFILES_PATH/profile"

  # fix colors
  tic $DPATH/terminal/xterm-256color-italic.terminfo


  echo "+-------------------------------+"
  echo "|        Installing Tmux        |"
  echo "+-------------------------------+"
  asdf plugin-add tmux
  asdf install tmux 3.0a
  asdf global tmux 3.0a
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  ln -fsv $DPATH/configs/tmux.conf $HOME/.tmux.conf


  echo "+---------------------------------+"
  echo "|        Installing Zshell        |"
  echo "+---------------------------------+"
  brew install zsh

  OMZ_PATH=$HOME/.oh-my-zsh
  CUSTOM_PATH=$OMZ_PATH/custom
  CUSTOM_PLUGINS_PATH=$CUSTOM_PATH/plugins
  CUSTOM_THEMES_PATH=$CUSTOM_PATH/themes

  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $CUSTOM_PLUGINS_PATH/zsh-autosuggestions
  git clone --depth=1 https://github.com/djui/alias-tips.git $CUSTOM_PLUGINS_PATH/alias-tips
  git clone --depth=1 https://github.com/bhilburn/powerlevel9k.git $CUSTOM_THEMES_PATH/powerlevel9k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $CUSTOM_THEMES_PATH/powerlevel10k

  ln -fsv $DPATH/terminal/zshell/zsh_env $HOME/.zsh_env
  ln -fsv $DPATH/terminal/zshell/zsh_ohmyzsh $HOME/.zsh_ohmyzsh
  ln -fsv $DPATH/terminal/zshell/zsh_prompt $HOME/.zsh_prompt
  ln -fsv $DPATH/terminal/zshell/zsh_aliases $HOME/.zsh_aliases
  ln -fsv $DPATH/terminal/zshell/zsh_functions $HOME/.zsh_functions
  ln -fsv $DPATH/terminal/zshell/zsh_langs $HOME/.zsh_langs
  ln -fsv $DPATH/terminal/zshell/zsh_commands $HOME/.zsh_commands
  ln -fsv $DPATH/terminal/zshell/zshrc $HOME/.zshrc
}

function neovim() {


  echo "+---------------------------------+"
  echo "|        Installing NeoVim        |"
  echo "+---------------------------------+"

  asdf plugin-add neovim
  asdf install neovim 0.4.3
  asdf global neovim 0.4.3

  brew install shellcheck the_silver_searcher
  gem install neovim solargraph
  pip install neovim
  pip3 install neovim python-language-server pylint
  yarn install -g neovim bash-language-server write-good markdownlint-cli eslint


  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  mkdir -p $HOME/.config/nvim
  ln -fvs $DPATH/nvim/init.vim $HOME/.config/nvim/init.vim
  ln -fvs $DPATH/nvim/keybindings.vim $HOME/.config/nvim/keybindings.vim
  ln -fvs $DPATH/nvim/plugins.vim $HOME/.config/nvim/plugins.vim
  ln -fvs $DPATH/nvim/settings.vim $HOME/.config/nvim/settings.vim
  ln -fvs $DPATH/nvim/ui.vim $HOME/.config/nvim/ui.vim
  ln -fvs $DPATH/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json

  nvim --headless +PluginInstall +qa

}

function link_configs() {

  echo "+-------------------------------+"
  echo "|        Linking Configs        |"
  echo "+-------------------------------+"

  ln -fvs $DPATH/configs/gitconfig $HOME/.gitconfig
  ln -fvs $DPATH/configs/gitignore $HOME/.gitignore
  ln -fvs $DPATH/configs/editorconfig $HOME/.editorconfig
  ln -fvs $DPATH/configs/eslintrc $HOME/.eslintrc
  ln -fvs $DPATH/configs/tigrc $HOME/.tigrc

}

main