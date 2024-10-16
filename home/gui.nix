{
  config,
  pkgs,
  ...
}: {
  gui_packages = with pkgs; [
    # i3status
    brightnessctl
    feh
    zoom-us
    discord
    slack
    telegram-desktop

    wireshark
    # HDR image viewer
    # tev

    maim
    gdbgui
    # Your One-Stop Publication Workbench
    zettlr

    obs-studio
    #blender
    steam
    # heroic
    lutris
    mpv
    # mdcat
    xdotool
    # networkmanager_dmenu
    networkmanagerapplet
    # Inlyne - a GPU powered, browserless, markdown + html viewer
    # inlyne
    graphviz

    # File manager
    # spacedrive
    nautilus

    steam-run

    okular
    oculante

    # wayland stuff
    mako
    wl-clipboard
    shotman

    swayidle #idle locker
    swaylock #screen locker
    swaywsr
    grim
    wdisplays

    pavucontrol
    pamixer
    # pulseaudioFull
    brightnessctl
    wlprop
  ];
}
