{
  inputs,
  ...
}:
{
  flake-file.inputs.yazi.url = "github:sxyazi/yazi";
  flake-file.inputs.kdeconnect-yazi = {
    url = "github:Deepak22903/kdeconnect-send.yazi";
    flake = false;
  };

  flake-file.nixConfig = {
  };

  nawa.apps._.yazi = {
    homeManager =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
      in
      {
        nix.settings = {
          substituters = [ "https://yazi.cachix.org" ];
          trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
        };
        programs.yazi = {
          enable = true;
          package = inputs.yazi.packages.${system}.default;
          enableFishIntegration = true;
          shellWrapperName = "y";
          initLua = ''
            require("recycle-bin"):setup()
          '';
          plugins = with pkgs.yaziPlugins; {
            inherit
              ouch
              mediainfo
              smart-paste
              recycle-bin
              ;
            kdeconnect = inputs.kdeconnect-yazi;
          };
          settings = {
            mgr.mouse_events = [ ];
            plugin = {
              prepend_loaders = [
                {
                  mime = "{audio,video,image/*}";
                  run = "mediainfo";
                }
              ];
              prepend_previewers = [
                {
                  mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
                  run = "ouch --show-file-icons";
                }
                {
                  mime = "{audio,video,image/*}";
                  run = "mediainfo";
                }
              ];
            };
            tasks.image_alloc = 1073741824; # 1G
          };
          keymap = {
            mgr = {
              prepend_keymap = [
                {
                  on = [ "<C-s>" ];
                  run = "plugin kdeconnect-send";
                  desc = "Send selected files via KDE Connect";
                }
                {
                  on = [
                    "R"
                    "b"
                  ];
                  run = "plugin recycle-bin";
                  desc = "Open Recycle Bin menu";
                }
                {
                  on = "!";
                  run = ''shell "$SHELL" --block'';
                  desc = "Open shell here";
                }
                {
                  on = [ "C" ];
                  run = "plugin ouch";
                  desc = "Compress with ouch";
                }
                {
                  on = "p";
                  run = "plugin smart-paste";
                  desc = "Paste into the hovered directory or CWD";
                }
              ];
            };
            input.prepend_keymap = [
              {
                on = "<Esc>";
                run = "close";
                desc = "Cancel input";
              }
            ];
          };
        };
      };
  };
}
