#!/usr/bin/env zsh

trap on_error SIGKILL SIGTERM

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"

# Success reporter
info() {
  echo -e "${CYAN}${*}${RESET}"
}

ask() {
  printf "${YELLOW}${*} [y/N]: ${RESET}"
}

# Error reporter
error() {
  echo -e "${RED}${*}${RESET}"
}

# Success reporter
success() {
  echo -e "${GREEN}${*}${RESET}"
}

# End section
finish() {
  success "Done!"
  echo
  sleep 1
}

on_start() {
  if [[ $(uname) != 'Darwin' ]]; then
    exit 1
  fi

  info '                             ____  _____ '
  info '    ____ ___   ____ _ _____ / __ \/ ___/ '
  info '   / __ `__ \ / __ `// ___// / / /\__ \  '
  info '  / / / / / // /_/ // /__ / /_/ /___/ /  '
  info ' /_/ /_/ /_/ \__,_/ \___/ \____//____/   '
  info '                                         '
  info "This script will guide you through installing macOS applications and cli tools."
  echo "It will not install anything without your direct agreement!"
  echo
  ask "Do you want to proceed with installation?" && read answer
  echo
  if [[ "${answer}" != "y" ]]; then
    exit 1
  fi
}

brew_install() {
  local cask=$1 program=$2

  [[ -z $program ]] && program=$cask

  if [[ $cask == 'cask' ]]; then
    info "Installing $program with cask..."
    brew cask install $program
  else
    info "Installing $program..."
    brew install $program
  fi

  finish
}

on_finish() {
  echo
  success "macOS applications was successfully installed!"
  echo
}

on_error() {
  echo
  error "Wow... Something serious happened!"
  error "Though, I don't know what really happened :("
  echo
  exit 1
}

main() {
  # Start
  on_start
  # CLI Tools
  brew_install wget
  brew_install yarn
  # Desktop applications
  brew_install cask telegram
  brew_install cask google-chrome
  brew_install cask firefox
  brew_install cask vlc
  brew_install cask iterm2
  brew_install cask toggl
  brew_install cask visual-studio-code
  brew_install cask slack
  brew_install cask transmission
  brew_install cask skype
  brew_install cask spectacle
  brew_install cask appcleaner
  brew_install cask the-unarchiver
  brew_install cask virtualbox
  brew_install cask figma
  brew_install cask zeplin
  # Finish
  on_finish
}

main "$*"
