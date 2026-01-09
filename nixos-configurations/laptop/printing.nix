{ pkgs, ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.enable = true;
  services.printing.browsing = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    hplip
    splix
    canon-cups-ufr2
    # cnijfilter2
  ];
}
