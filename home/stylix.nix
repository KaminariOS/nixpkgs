{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

    image = let
      wallpapers = builtins.fetchGit {
        url = "https://github.com/alyraffauf/wallpapers.git";
        rev = "ff956327520f2ecdd0f8b1cdab4420bef4095d38";
        ref = "master";
      };
    in "${wallpapers}/wallhaven-mp886k.jpg";

    imageScalingMode = "fill";
    polarity = "light";

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 34;
    };

    fonts = {
      monospace = {
        name = "UbuntuSansMono Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["UbuntuSans"];};
      };

      sansSerif = {
        name = "UbuntuSans Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["UbuntuSans"];};
      };

      serif = {
        name = "Vegur";
        package = pkgs.vegur;
      };

      sizes = {
        applications = 14;
        desktop = 13;
        popups = 15;
        terminal = 16;
      };
    };

    opacity = {
      applications = 1.0;
      desktop = 0.4;
      terminal = 0.8;
      popups = 0.8;
    };
  };
}
