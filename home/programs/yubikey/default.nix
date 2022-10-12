{ pkgs, ... }:

{
  home.packages = with pkgs; [
    yubikey-manager  # yubikey manager cli
    yubioath-desktop # yubikey OTP manager (gui)
  ];

  xdg.configFile."Yubico/Yubico Authenticator.conf".source = ./authenticator.conf;
}
