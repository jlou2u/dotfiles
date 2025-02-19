{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.startup_mode = "Maximized";
      selection.save_to_clipboard = true;
      terminal.shell = {
        args = [
          "new-session"
          "-A"
          "-D"
          "-s"
          "main"
        ];
        program = "${pkgs.tmux}/bin/tmux";
      };
    };
  };
}
