{
  nawa.apps._.rmpc = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.rmpc ];
        services.mpd = {
          enable = true;
          extraConfig = ''
            audio_output {
              type "alsa"
              name "My ALSA"
              mixer_type		"hardware"
              mixer_device	"default"
              mixer_control	"PCM"
            }
          '';
        };
      };
  };
}
