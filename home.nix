{ pkgs, config, ... }:

{
  nixGL.packages = import <nixgl> { inherit pkgs; };

  home = {
    username = "agis";
    homeDirectory = "/home/agis";

    #  This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      nixfmt-rfc-style
      fortune
      htop
      superfile
      nodejs_20
      lz4
      lua
      mate.engrampa
      neofetch
      direnv
      http-server
      cloudflare-warp
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/agis/etc/profile.d/hm-session-vars.sh

    extraOutputsToInstall = [ "man" ];
  };

  imports = [
    ./nvim.nix
    <catppuccin/modules/home-manager>
    ./starship.nix
  ];

  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  programs = {
    home-manager.enable = true;
    man.enable = false;

    ghostty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.ghostty;
      settings = {
        font-size = 11;
        palette = [
          "15=#ffffff"
        ];
      };
    };

    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
