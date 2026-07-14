{ pkgs, ... }:
{
  force = true;
  default = "ddg";
  privateDefault = "Startpage";
  order = [
    "ddg"
    "Startpage"
    "GitHub"
    "NixOS Packages"
    "NixOS Options"
    "NixOS Wiki"
    "Home Manager"
    "My NixOS"
    "Noogle"
  ];
  engines =
    let
      nix-icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    in
    {
      "Startpage" = {
        urls = [
          {
            template = "https://www.startpage.com/sp/search?query={searchTerms}";
          }
        ];
        icon = "https://www.startpage.com/sp/cdn/favicons/favicon-gradient.ico";
        definedAliases = [ "@sp" ];
        updateInterval = 24 * 60 * 60 * 1000;
      };
      "GitHub" = {
        urls = [
          {
            template = "https://github.com/search?q={searchTerms}";
          }
        ];
        icon = "https://github.com/favicon.ico";
        definedAliases = [ "@gh" ];
      };
      "NixOS Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = nix-icon;
        definedAliases = [
          "@np"
          "@nixpkgs"
        ];
      };
      "NixOS Options" = {
        urls = [
          {
            template = "https://search.nixos.org/options";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = nix-icon;
        definedAliases = [
          "@no"
          "@nixopts"
        ];
      };
      "NixOS Wiki" = {
        urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
        icon = nix-icon;
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@nw" ];
      };
      "Home Manager" = {
        urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
        icon = "https://home-manager-options.extranix.com/images/favicon.png";
        definedAliases = [
          "@hm"
          "@home"
          "'homeman"
        ];
      };
      "My NixOS" = {
        urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
        icon = "https://mynixos.com/favicon.ico";
        definedAliases = [
          "@mn"
          "@nx"
          "@mynixos"
        ];
      };
      "Noogle" = {
        urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
        icon = nix-icon;
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = [
          "@noogle"
          "@ng"
        ];
      };
      "bing".metaData.hidden = true;
      "ebay".metaData.hidden = true;
      "google".metaData.hidden = true;
      "Perplexity".metaData.hidden = true;
    };
}
