{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages.nix.enable = true;
  languages.shell.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  git-hooks.hooks = {
    shellcheck.enable = true;
    mdsh.enable = true;
    nixfmt-rfc-style.enable = true;
    # couldnt disable on .p10k.zsh, maybe investigate more later
    # shfmt.enable = true;
    yamlfmt.enable = true;
    check-toml.enable = true;
    check-json.enable = true;
    pretty-format-json.enable = true;
    check-merge-conflicts.enable = true;
    gptcommit.enable = true;

    # pyhon specific
    autoflake.enable = true;
    black.enable = true;
    flake8.enable = true;
    isort.enable = true;
    mypy.enable = true;
    pylint.enable = true;
    python-debug-statements.enable = true;
    pyupgrade.enable = true;
    ruff.enable = true;
    ruff-format.enable = true;

  };

  # See full reference at https://devenv.sh/reference/options/
}
