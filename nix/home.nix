{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alb";
  home.homeDirectory = "/Users/alb";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.neovim
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.fastfetch

    # node
    pkgs.node2nix
    pkgs.nodejs
    pkgs.nodePackages.pnpm
    pkgs.yarn

    # lazyvim
    pkgs.lazygit
    pkgs.fzf
    pkgs.ripgrep
    pkgs.fd
    pkgs.libgccjit
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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
  #  /etc/profiles/per-user/alb/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # install git
  programs.git = {
    enable = true;
    userName = "alhansrisuk";
    userEmail = "alhansrisuk@gmail.com";
  };

  # install kitty
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 11;
    };
    settings = {
      enable_audio_bell = false;
      background_opacity = "0.95";
      dynamic_background_opacity = true;
    };
    themeFile = "gruvbox-dark";
   };

  # install fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set --universal --erase fish_greeting
    '';
    plugins = [
     { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish.src; }
    ];
  };

  # install tmux
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # set default shell to fish
      set-option -g default-shell ${pkgs.fish}/bin/fish

      # remap prefix from 'C-b' to 'C-a'
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Enable mouse control (clickable windows, panes, resizable panes)
      set -g mouse on

      set -s escape-time 0
    '';
  };
 }
