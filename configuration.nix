{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host and networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Localization
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "ter-v16b";
    keyMap = "us";
  };

  # User setup
  users.users.jaspreet = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    packages = with pkgs; [
      firefox
      kitty
      neovim
    ];
  };

  # Fonts (nerd-fonts)
  fonts.fontDir.enable = true;
   fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts._3270
    nerd-fonts.adwaita-mono
    nerd-fonts.agave
    nerd-fonts.anonymice
    nerd-fonts.arimo
    nerd-fonts.atkynson-mono
    nerd-fonts.aurulent-sans-mono
    nerd-fonts.bigblue-terminal
    nerd-fonts.bitstream-vera-sans-mono
    nerd-fonts.blex-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    nerd-fonts.code-new-roman
    nerd-fonts.comic-shanns-mono
    nerd-fonts.commit-mono
    nerd-fonts.cousine
    nerd-fonts.d2coding
    nerd-fonts.daddy-time-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.departure-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.envy-code-r
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.geist-mono
    nerd-fonts.go-mono
    nerd-fonts.gohufont
    nerd-fonts.hack
    nerd-fonts.hasklug
    nerd-fonts.heavy-data
    nerd-fonts.hurmit
    nerd-fonts.im-writing
    nerd-fonts.inconsolata
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata-lgc
    nerd-fonts.intone-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.jetbrains-mono
    nerd-fonts.lekton
    nerd-fonts.liberation
    nerd-fonts.lilex
    nerd-fonts."m+"
    nerd-fonts.martian-mono
    nerd-fonts.meslo-lg
    nerd-fonts.monaspace
    nerd-fonts.monofur
    nerd-fonts.monoid
    nerd-fonts.mononoki
    nerd-fonts.noto
    nerd-fonts.open-dyslexic
    nerd-fonts.overpass
    nerd-fonts.profont
    nerd-fonts.proggy-clean-tt
    nerd-fonts.recursive-mono
    nerd-fonts.roboto-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.shure-tech-mono
    nerd-fonts.space-mono
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.tinos
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.victor-mono
    nerd-fonts.zed-mono
  ];


  # Wayland and Wayland-native environment
  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
    git wget curl vim htop unzip kbd
    wayland xwayland wl-clipboard
    grim slurp swaybg swaylock waybar wofi mako
    home-manager
  ];

  # Enable dbus (needed for many Wayland apps)
  services.dbus.enable = true;

  # PipeWire (no pulseaudio)
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    pulse.enable = true;
    jack.enable = false;
  };

  # Home Manager (if not using flakes, remove if using flake setup)
  # imports = [ <home-manager/nixos> ]; # Uncomment if using non-flake home-manager
  # home-manager.users.jaspreet = {
  #   home.stateVersion = "25.05";
  # };

  system.stateVersion = "25.05";
}

