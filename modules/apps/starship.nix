{
  nawa.apps._.starship = {
    homeManager = {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          format = " $username\$hostname\$directory\$git_branch\$git_state\$git_status\$cmd_duration\$line_break\$character";
          add_newline = true;
          username = {
            format = "[$user]($style) ";
          };
          character = {
            format = " $symbol ";
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
          package.disabled = true;
        };
      };
    };
  };
}
