{
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu -i
    rofi_highlight = True
    [editor]
    gui_if_available = True
  '';
  services.network-manager-applet.enable = true;
}
