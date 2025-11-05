{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      firefoxpwa
      vesktop
      obsidian
    ];

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      ExtensionSettingsa = let
        mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        });
      in
      # Use `about:debugging#/runtime/this-firefox` to find Extension ID
      mkExtensionSettings {
        "{74145f27-f039-47ce-a470-a662b129930a}" = "ClearURLs";
        "gdpr@cavi.au.dk" = "Consent-O-Matic";
        "firefox-compact-dark@mozilla.org" = "Dark";
        "@contain-facebook" = "Facebook Container";
        "{6c00218c-707a-4977-84cf-36df1cef310f}" = "Port Authority";
        "jid1-MnnxcxisBPnSXQ@jetpack" = "Privacy Badger";
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = "Proton Pass: Free Password Manager";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "Return YouTube Dislike";
        "uBlock0@raymondhill.net" = "uBlock Origin";
        "{34daeb50-c2d2-4f14-886a-7160b24d66a4}" = "Youtube-shorts block";
      };
    };
  };

  xdg.mimeApps = let
    value = let
      zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta;
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
        inherit name value;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
