class people::warrenbailey {
  include chrome
  include dropbox
  include git
  include vagrant
  include wget
  include skype
  include slack
  include homebrew
  include brewcask # taps homebrew-cask / installs brew-cask

  $home = "/Users/${::luser}"
  $projects = "${home}/Dev"
  $dotfiles = "${projects}/dotfiles"

  file { [$projects]:
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
  
  class { 'osx::sound::interface_sound_effects':
    enable => false
  }
  osx::recovery_message { 'If this Mac is found, please email warren@warrenbailey.net': }


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
      'python',
      'python3',
      'rabbitmq',
      'packer',
    ]:
    ensure => present,
  }

  package { 'go':
    ensure          => present,
    install_options => '--cross-compile-common',
  }
  
}
