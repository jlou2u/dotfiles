{
  config,
  pkgs,
  agenix,
  secrets,
  ...
}:

let
  jlou2u = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMiQj3fB0odhdbTVP2sE/XPp3KyxA7nqTbVF9VOXP5zm";
  users = [ jlou2u ];
  systems = [ ];
in
{
  age = {
    identityPaths = [
      "/home/jlou2u/.ssh/id_ed25519"
    ];
    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "/home/jlou2u/.ssh/id_github";
        file = "${secrets}/ssh-key.age";
      };
    };
  };
}
