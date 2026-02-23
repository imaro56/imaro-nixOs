{ pkgs, ... }:

let
  # Nerd Font icons via JSON unicode escapes (nix strips literal glyphs)
  icon = char: builtins.fromJSON ''"${char}"'';
  nf = {
    git_branch = icon ''\ue0a0'';
    python = icon ''\ue606'';
    rust = icon ''\udb85\ude17''; # U+F1617
    nodejs = icon ''\ue718'';
    golang = icon ''\ue627'';
    docker = icon ''\uf308'';
    nix = icon ''\uf313'';
    lock = icon ''\udb80\udf3e''; # U+F033E
    vim = icon ''\udb81\udd57''; # U+F0557
    nixos = icon ''\uf313'';
    arch = icon ''\uf303'';
    debian = icon ''\uf306'';
    fedora = icon ''\uf30a'';
    ubuntu = icon ''\uf31b'';
    windows = icon ''\udb80\udf72''; # U+F0372
  };
in
{
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        rebuild = "cd ~/nixos-config && git add . && sudo nixos-rebuild switch --flake .";
        conf = "cd ~/nixos-config && vim .";
      };
      shellAbbrs = {
        "--help" = {
          position = "anywhere";
          expansion = "--help | bat -plhelp";
        };
        "-h" = {
          position = "anywhere";
          expansion = "-h | bat -plhelp";
        };
      };
      interactiveShellInit = ''
        # Catppuccin Mocha fish colors
        set -g fish_color_normal cdd6f4
        set -g fish_color_command 89b4fa
        set -g fish_color_param f2cdcd
        set -g fish_color_keyword f38ba8
        set -g fish_color_quote a6e3a1
        set -g fish_color_redirection f5c2e7
        set -g fish_color_end fab387
        set -g fish_color_comment 7f849c
        set -g fish_color_error f38ba8
        set -g fish_color_gray 6c7086
        set -g fish_color_selection --background=3e4058
        set -g fish_color_search_match --background=3e4058
        set -g fish_color_option a6e3a1
        set -g fish_color_operator f5c2e7
        set -g fish_color_escape f2cdcd
        set -g fish_color_autosuggestion 6c7086
        set -g fish_color_cancel f38ba8
        set -g fish_color_cwd f9e2af
        set -g fish_color_user 94e2d5
        set -g fish_color_host 89b4fa
        set -g fish_pager_color_progress 6c7086
        set -g fish_pager_color_prefix f5c2e7
        set -g fish_pager_color_completion cdd6f4
        set -g fish_pager_color_description 6c7086

        # Greeting with fastfetch in kitty/ghostty
        function fish_greeting
          if string match -q "xterm-kitty" $TERM; or string match -q "xterm-ghostty" $TERM
            fastfetch
          end
        end

        # Re-show greeting on clear
        function clear --wraps fish_clear
          command clear
          if string match -q "xterm-kitty" $TERM; or string match -q "xterm-ghostty" $TERM
            fish_greeting
          end
        end
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        command_timeout = 1000;
        palette = "catppuccin_mocha";
        format = "$directory$shell$all$fill$line_break$character";

        character = {
          success_symbol = "[✿](bold teal)";
          error_symbol = "[✿](red)";
          vimcmd_symbol = "[${nf.vim} ](bold rosewater)";
        };

        fill.symbol = " ";

        shell = {
          fish_indicator = "🌊";
          unknown_indicator = "👀";
          disabled = false;
        };

        directory = {
          truncation_symbol = "…/";
          truncation_length = 4;
          read_only = " ${nf.lock}";
        };

        git_branch.symbol = "${nf.git_branch} ";
        python.symbol = "${nf.python} ";
        rust.symbol = "${nf.rust} ";
        nodejs.symbol = "${nf.nodejs} ";
        golang.symbol = "${nf.golang} ";
        docker_context.symbol = "${nf.docker} ";
        nix_shell.symbol = "${nf.nix} ";

        os = {
          disabled = false;
          symbols = {
            NixOS = "${nf.nixos} ";
            Arch = "${nf.arch} ";
            Debian = "${nf.debian} ";
            Fedora = "${nf.fedora} ";
            Ubuntu = "${nf.ubuntu} ";
            Windows = "${nf.windows} ";
          };
        };

        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--color=bg+:#313244,bg:-1,spinner:#F5E0DC,hl:#F38BA8"
        "--color=fg:#CDD6F4,header:#F38BA8,info:#F5E0DC,pointer:#F5E0DC"
        "--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#F5E0DC,hl+:#F38BA8"
        "--color=selected-bg:#45475A"
        "--color=border:#313244,label:#CDD6F4,gutter:-1"
        "--no-border"
        "--layout=reverse"
      ];
    };

    bat = {
      enable = true;
      config.theme = "Catppuccin Mocha";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
