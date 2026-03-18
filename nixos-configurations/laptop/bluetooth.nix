{ pkgs, lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      Gerneral.Experimental = true;
    };
  };

  systemd.user.services.obex = {
    serviceConfig.ExecStart = lib.mkForce [
      ""
      (pkgs.bluez + "/libexec/bluetooth/obexd --root=./Downloads --auto-accept")
    ];
    overrideStrategy = "asDropin";
  };
}
