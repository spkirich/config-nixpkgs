# Home Manager configuration.

{ config, pkgs, ... }:

{
  # Hi! My name is...
  home.username = "sery";

  # Welcome to my home directory!
  home.homeDirectory = "/home/sery";

  home.packages = with pkgs; [
    brightnessctl
    pamixer
    pcmanfm
    texlive.combined.scheme-full
    tdesktop
  ];

  # Feel free to manage yourself...
  programs.home-manager.enable = true;

  # Hello! My Bash shell.
  programs.bash.enable = true;

  # Let's deal with X...
  xsession.enable = true;

  xsession.windowManager.bspwm = {
    enable = true;

    # I do like wide borders!
    settings.border_width = 2;

    # And wide gaps too...
    settings.window_gap = 12;

    settings = {
      focus_follows_pointer = true;
      pointer_follows_focus = true;
    };

    rules = {
      "Zathura" = { state = "tiled"; };
    };

    monitors = {
      eDP = [ "1" "2" "3" "4" "5" "6" "7" "8" ];
    };

    startupPrograms = [
      "systemctl --user restart polybar"
    ];
  };

  services.sxhkd = {
    enable = true;

    keybindings = {
      # Call a terminal emulator.
      "super + Return" = "alacritty";

      # Call a file manager.
      "super + n" = "pcmanfm";

      # Call a web browser.
      "super + w" = "firefox";

      # Call an application menu.
      "super + d" = "rofi -show drun";

      # Control the sound volume.
      "XF86Audio{Mute,LowerVolume,RaiseVolume}" = "pamixer -{t,d 10,i 10}";

      # Control the screen brightness.
      "XF86MonBrightness{Up,Down}" = "brightnessctl set {+10%,10%-}";

      # Close or kill the focused node.
      "super + {_,shift + }c" = "bspc node -{c,k}";

      # Focus the node in the given direction.
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";

      # Send the focused node to the given direction.
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";

      # Focus the given desktop.
      "super + {1-8}" = "bspc desktop -f '^{1-8}'";

      # Send the focused node to the given desktop.
      "super + shift + {1-8}" = "bspc node -d '^{1-8}'";
    };
  };

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      pulseSupport = true;
    };

    config = {
      "bar/main" = {
        # Iosevka looks nice.
        font-0 = "Iosevka:size=12";

        # Let's speak Russian!
        locale = "ru_RU.UTF-8";

        # Some modules on the left...
        modules-left = "bspwm xwindow";

        # In between...
        modules-center = "date";

        # And on the right too! Yeah, more modules!
        modules-right = "network pulseaudio battery xkeyboard";

        # Some appearance settings.
        padding = 1; separator = " | ";
      };

      "module/xwindow" = {
        type = "internal/xwindow";

        # Show the title of the focused node.
        format = "<label>"; label = "%title:0:80%";
      };

      "module/bspwm" = {
        type = "internal/bspwm";

        format = "<label-state>";

        label-focused = "%name%";
        label-focused-foreground = "#C0CAF5";

        label-occupied = "%name%";
        label-occupied-foreground = "#7D84A0";

        label-empty = "%name%";
        label-empty-foreground = "#3B3E4B";

        label-separator = " ";
      };

      "module/date" = {
        type = "internal/date";

        # Show the clock.
        date = "%a %d %b %H:%M";
      };

      "module/network" = {
        type = "internal/network";

        # My Wi-Fi device.
        interface = "wlp3s0";

        # If connected, show a Wi-Fi icon...
        format-connected = "直 <label-connected>";

        # And the network ESSID.
        label-connected = "%essid%";

        # Otherwise show a crossed out Wi-Fi icon...
        format-disconnected = "睊 <label-disconnected>";

        # And a corresponding label.
        label-disconnected = "нет сети";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        # Unless muted, show an icon...
        format-volume = "墳 <label-volume>";

        # And the current sound volume.
        label-volume = "%percentage:3%%";

        # Otherwise show another icon...
        format-muted = "婢 <label-muted>";

        # And a label.
        label-muted = "выкл";
      };

      "module/battery" = {
        type = "internal/battery";

        battery = "BAT1";
        adapter = "ACAD";

        # If discharging, show a corresponding icon...
        format-discharging = "<ramp-capacity> <label-discharging>";

        # And the current battery percentage.
        label-discharging = "%percentage:3%%";

        # If charging, show another icon...
        format-charging = " <label-charging>";

        # And also the current percentage.
        label-charging = "%percentage:3%%";

        # If full, show an icon...
        format-full = " <label-full>";

        # And the percentage too.
        label-full = "%percentage:3%%";

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
      };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";

        # Show a keyboard icon...
        format = " <label-layout>";

        # And the current layout.
        label-layout = "%layout%";
      };
    };

    script = "exec polybar main &";
  };

  services.picom = {
    enable = true;

    # Look at these effects!
    fade = true; shadow = true;
  };

  programs.zathura = {
    enable = true;
  };

  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun";
    };

    theme = "Arc-Dark";
  };

  programs.alacritty = {
    enable = true;

    # I do love this transparency!
    settings.window.opacity = 0.75;

    settings.window.padding = {
      x = 4; y = 4;
    };
  };

  # Hello! My Firefox browser!
  programs.firefox.enable = true;

  programs.git = {
    enable = true;

    # Hello Git! My name is...
    userName = "Sergey Kirichenko";

    # Feel free to contact me.
    userEmail = "spkirich@gmail.com";
  };

  gtk = {
    enable = true;

    font = {
      # Iosevka once again!
      name = "Iosevka"; size=12;
    };

    theme = {
      # I really like Arc Dark theme.
      name = "Arc-Dark"; package = pkgs.arc-theme;
    };

    iconTheme = {
      # Papirus Dark icon theme is very nice too.
      name = "Papirus-Dark"; package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;

    # No theme mess here!
    platformTheme = "gtk";
  };

  home.stateVersion = "22.11";
}
