{
  nawa.apps._.zk = {
    homeManager =
      { config, pkgs, ... }:
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;
        inherit (config.home) homeDirectory;

        zkNotebookDir = "${homeDirectory}/Documents/second-brain";
        zkConfigDir = "${homeDirectory}/majarra/config/zk";
      in
      {
        home.packages = [ pkgs.zk ];
        home.sessionVariables.ZK_NOTEBOOK_DIR = zkNotebookDir;

        xdg.configFile = {
          "zk" = {
            source = mkOutOfStoreSymlink zkConfigDir;
            recursive = true;
          };
        };
      };
  };
}
