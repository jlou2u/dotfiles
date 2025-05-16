{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Justin Lewis";
    userEmail = "justin.lewis@gmail.com";
    signing = {
      key = "01B989E591C255BD";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        navigate = true;
      };
    };
    extraConfig = {
      diff.tool = "vimdiff";
      difftool.prompt = "false";
      log.date = "relative";
      format.pretty = "format:%C(auto,yellow)%h%C(auto,red)% G? %C(auto,cyan)%>(12,trunc)%ad %C(auto,bold blue)%<(7,trunc)%aN%C(auto,bold yellow)%gD%D %C(auto,reset)%s";
      core.fileMode = "false";
      core.editor = "nvim";
    };
  };
}
