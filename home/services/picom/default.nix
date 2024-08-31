{
  services.picom = {
    # enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 0.96;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    opacityRules = ["100:name *= 'i3lock'" "100:name *= 'Firefox'"];
    shadow = true;
    shadowOpacity = 0.95;
    settings = {
      corner-radius = 6;
      round-borders = 1;
    };
  };
}
