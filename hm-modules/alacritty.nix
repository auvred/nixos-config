{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      mouse.hide_when_typing = true;
      font = {
        normal.family = "CaskaydiaMono Nerd Font Mono";
        size = 6;
        offset = {
          x = 0;
          y = -2;
        };
      };

      # tweaked monokai_charcoal theme
      colors = {
        primary = {
          background = "#000000";
          foreground = "#FFFFFF";
        };

        normal = {
          black = "#636363";
          red = "#f4005f";
          green = "#82bc25";
          yellow = "#fa8419";
          blue = "#9d65ff";
          magenta = "#f4005f";
          cyan = "#58d1eb";
          white = "#c4c5b5";
        };

        bright = {
          black = "#625e4c";
          red = "#f4005f";
          green = "#98e024";
          yellow = "#e0d561";
          blue = "#9d65ff";
          magenta = "#f4005f";
          cyan = "#58d1eb";
          white = "#f6f6ef";
        };
      };
    };
  };
}
