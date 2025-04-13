{
  users.users.chris = {
    isNormalUser = true;
    
    initialPassword = "0304";
    description = "Christoffer Hald Christensen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "usb"
      "input"
      "disk"
    ];
    createHome = true;
  };

  nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.1.5" ];
}
