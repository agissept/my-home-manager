{ pkgs, lib, ...} : 

{
  programs.starship = {
      enable = true;

      settings = {
        format = ''
          ''${custom.poker}''${custom.spotify}
          ''${custom.nix_file}$all      
        '';

        custom.spotify = {
          command = "spacelab np";
            when = "test -n '$(spacelab np)'";
            symbol = "";
            style = "bg:#1DB954 fg:black";
            format = " - [](#1DB954)[$symbol ($output )]($style)[](#1DB954)";
          };

        custom.poker = {
          description = "Poker playing hands";
          command = "spacelab pp";
          when = "true";
          format = "$output";
        };

        custom.nix_file = {
           symbol = " ";
           detect_extensions = ["nix"];
        };

        aws.disabled = true;

        nix_shell = {
          symbol = " ";
          format = "via [$symbol$state( \($name\))]($style) ";
        };
      };
  };
}
