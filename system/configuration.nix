# Edit this configuration file to define what should be installed on
# your system.  Help is available in the default.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, lib
, pkgs
, inputs
, ...
}:
let
  customFonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
      "Iosevka"
    ];
  };

  myfonts = pkgs.callPackage fonts/default.nix { inherit pkgs; };
in
{
  imports = [
    # Window manager
    #./wm/xmonad.nix
    # Binary cache
    ./cachix.nix
  ];

  networking = {
    # Enables wireless support and openvpn via network manager.
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-mozc ];
  # };

  # Set your time zone.
  time.timeZone = "America/Denver";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = let themes = pkgs.callPackage ./sddm-theme.nix { }; in
    (with pkgs; [
      firejail
      neovim
      wget
      home-manager
      # kwallet-pam
    ]) ++
    (with pkgs.libsForQt5.qt5; [ qtgraphicaleffects qtsvg qtquickcontrols ]) ++
    [ themes.sddm-sugar-candy ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable Docker & VirtualBox support.
  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  users.extraGroups.vboxusers.members = [ "kosumi" ];

   # hardware.pulseaudio = {
   #   enable = true;
   #   package = pkgs.pulseaudioFull;
   # };

  security.rtkit.enable = true;

  # Scanner backend
  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.epkowa pkgs.sane-airscan ];
    };
    graphics.enable32Bit = true;
    bluetooth.enable = true;
  };

  services = {
    # Mount MTP devices

    gvfs.enable = true;
    #gnome.gnome-keyring.enable = true;
    tailscale.enable = true;

    displayManager = {
      # Display Manage
      sddm = {
        enable = true;
        enableHidpi = true;
        theme = "sugar-candy";
      };
      # lightdm = {
      #   enable = true;
      #   background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
      #   greeters = {
      #     gtk = {
      #       theme = {
      #         name = "Dracula";
      #         package = pkgs.dracula-theme;
      #       };
      #       cursorTheme = {
      #         name = "Dracula-cursors";
      #         package = pkgs.dracula-theme;
      #         size = 16;
      #       };
      #     };
      #   };
      # };
      defaultSession = "none+i3";
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      windowManager.i3.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      allowSFTP = true;
    };

    blueman.enable = true;
    # Yubikey smart card mode (CCID) and OTP mode (udev)
    pcscd.enable = true;
    udev.packages = with pkgs; [ yubikey-personalization via ];
    udev.extraRules = ''
      # https://github.com/stlink-org/stlink/blob/32e8dcc8b5dbed7b6412e7838ea1b2c41f0247fd/config/udev/rules.d/49-stlinkv1.rules
      ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", TAG+="uaccess"

      # STM32F3DISCOVERY rev A/B - ST-LINK/V2
      ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", TAG+="uaccess"

      # STM32F3DISCOVERY rev C+ - ST-LINK/V2-1
      ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"
    '';

    # SSH daemon.
    sshd.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };

    postgresql = {
      enable = true;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
        CREATE DATABASE nixcloud;
        GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
      '';
    };
  };

  # Making fonts accessible to applications.
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-emoji
      ubuntu_font_family
      jetbrains-mono
      customFonts
      font-awesome
      myfonts.flags-world-color
      myfonts.icomoon-feather

      fira-code
      fira-code-symbols
      unifont
      ipafont
      
      noto-fonts
      # noto-fonts-cjk-serif
      # noto-fonts-cjk-sans
      arphic-ukai
      noto-fonts-lgc-plus
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto fonts" "AR PL UKai HK" "Ubuntu" ];
        sansSerif = [ "Noto fonts" "AR PL UKai HK" "IPAPGothic" "Ubuntu" ];
        monospace = [ "AR PL UKai HK" "fira-code" "font-awesome" ];
        emoji = [ "Noto Emoji" ];
      };
    };
  };

  programs = {
    fish.enable = true;
    fuse.userAllowOther = true;
    partition-manager.enable = true;
    #xwayland.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    ssh.extraConfig = ''
      Host *.cloudlab.us
        ForwardAgent yes
    '';
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kosumi = {
    isNormalUser = true;
    extraGroups = [ "docker" "networkmanager" "wheel" "scanner" "lp" ]; # wheel for ‘sudo’.
    shell = pkgs.fish;
  };

  security = {
    # Yubikey login & sudo
    pam.yubico = {
      enable = true;
      debug = false;
      mode = "challenge-response";
    };
    pam.services.login.enableGnomeKeyring = true;
    # pam.services.kwallet.enableKwallet = true;
    # Sudo custom prompt message
    sudo.configFile = ''
      Defaults lecture=always
      Defaults lecture_file=${misc/groot.txt}
    '';

    # lets users use sudo without password
    sudo.wheelNeedsPassword = false;
  };

  nixpkgs.config.allowUnfree = true;

  # Nix daemon config
  nix = {
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nixPath = [ "nixpkgs=${pkgs.path}" ];

    # Flakes settings
    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      # Automate `nix store --optimise`
      auto-optimise-store = true;

      # Required by Cachix to be used as non-root user
      trusted-users = [ "root" "kosumi" ];

      experimental-features = [ "nix-command" "flakes" ];

      # Avoid unwanted garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man default.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
