{ firefoxProfile, ... }: {
  home.file = {
    ".config/nvim" = { 
      source = ./AstroNvim;
      recursive = true;
    };
    ".config/foot".source = ./foot;
    ".config/starship.toml".source = ./starship/starship.toml;
    ".config/sway".source = ./sway;
    ".config/waybar".source = ./waybar;
    ".config/tofi".source = ./tofi;
    ".ideavimrc".source = ./ideavim/.ideavimrc;
    ".config/discord/settings.json".source = ./discord_updates_shut_up/settings.json;
    ".util".source = ./util;
    
    # More info: https://github.com/mbnuq/sidebery/iki/Firefox-Styles-Snippets-(via-userChrome.css)
    ".mozilla/firefox/${firefoxProfile}/chrome/userChrome.css".source = ./firefox/userChrome.css;
    # "???".source = ./firefox/sidebery/sidebery.json;
  };
}
