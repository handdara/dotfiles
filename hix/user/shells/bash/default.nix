{config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      z = "cd";
      e = "ls";
      ea = "ls -a";
      ela = "ls -la";
      ga = "git add";
      gs = "git status";
      gcom = "git commit";
      gdh = "git diff HEAD";
      j = "just";
    };
  };
}
