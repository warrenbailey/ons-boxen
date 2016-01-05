class people::dhilton {
  include chrome
  include dropbox
  include git
  include vagrant
  include wget
  include skype
  include slack
  include brewcask # taps homebrew-cask / installs brew-cask

  $home = "/Users/${::luser}"
  $projects = "${home}/projects"
  $projects_personal = "${projects}/personal"
  $dotfiles = "${projects}/dotfiles"

  file { [$projects, $projects_personal]:
    ensure  => directory,
  }


  Boxen::Osx_defaults {
    user => $::luser,
  }

  package {
    [
      'gpg-agent',
      'tmux',
      'tree',
    ]:
    ensure => present,
  }
  
  #Mac tweaks
  include osx::no_network_dsstores
  include osx::dock::autohide
  include osx::disable_app_quarantine
  include osx::global::disable_autocorrect
  include osx::global::tap_to_click
  include osx::keyboard::capslock_to_control
  include osx::finder::empty_trash_securely
  include osx::dock::clear_dock
  include osx::no_network_dsstores
  include osx::dock::dim_hidden_apps

  class { 'osx::dock::icon_size': size => 40 }
  class { 'osx::dock::position':
    position => 'left'
  }
  class { 'osx::sound::interface_sound_effects':
    enable => false
  }
  osx::recovery_message { 'If this Mac is found, please @danhilton': }


  boxen::osx_defaults { 'show battery percentage remaining':
    ensure => present,
    domain => 'com.apple.menuextra.battery',
    key    => 'ShowPercent',
    type   => 'string',
    value  => 'YES',
    user   => $::boxen_user,
  }


  #apps
  include caffeine
  include chrome
  include git
  include java

  # Install packages using homebrew-cask
  package { 'virtualbox': provider => 'brewcask' }
  package { 'dockertoolbox': provider => 'brewcask'}
  package {'atom': provider => 'brewcask'}

  #Shell
  include zsh
  include ohmyzsh

  # These are all Homebrew packages
  package {
    [
      'apg',
      'docker',
      'entr',
      'gnu-sed',
      'terraform',
      'tig',
      'pass',
      'watch',
    ]:
    ensure => present,
  }

  package { 'go':
    ensure          => present,
    install_options => '--cross-compile-common',
  }
  
  package { 'python':
    ensure => present,
  } ->
  package { [
    'virtualenv',
    'virtualenvwrapper',
  ]:
    ensure   => present,
    provider => 'pip',
  }
}
