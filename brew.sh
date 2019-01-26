#!/usr/bin/env bash

# Like the other install script, this is from Mathias Bynens with slight modifications by me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

echo "Installing brew formulae..."

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# This is needed for python support on Neovim for YouCompleteMe
# Please see:
# * https://github.com/neovim/neovim/issues/1315
# * https://stackoverflow.com/questions/17271319/how-do-i-install-pip-on-macos-or-os-x
brew install python3
brew unlink python3
brew link python3
pip3 install --user --upgrade neovim

# Change the user's life forever
# God bless the best text editor on earth
brew install vim --with-override-system-vi
brew install neovim --with-override-system-vi
nvim +silent +PlugInstall +qall
python3 ~/.config/nvim/plugged/YouCompleteMe/install.py

# vim's best friend
brew install tmux

brew install git
brew install git-lfs
brew install ssh-copy-id

brew install docker
brew install docker-compose
brew install docker-machine

# Remove outdated versions from the cellar.
brew cleanup