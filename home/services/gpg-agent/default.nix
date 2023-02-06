{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableFishIntegration = true;
    enableSshSupport = true;
  };
}
