{ config, pkgs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "honeycomb-systems/skeleton";

  # https://devenv.sh/packages/
  packages = [
    pkgs.ctlptl
    pkgs.curl
    pkgs.docker
    pkgs.fnm
    pkgs.git
    pkgs.kubernetes-helm
    pkgs.hostctl
    pkgs.istioctl
    pkgs.kind
    pkgs.kubectl
    pkgs.tilt
    pkgs.yq
  ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
  '';

  # TODO: revisit language setup after installing direnv
  # Provide subdirectory setup specific to each service
  # https://devenv.sh/languages/
  # languages.nix.enable = true;
  languages.go.enable = true;
  languages.python.enable = true;
  languages.python.version = "3.12.0";
  #languages.python.venv.enable = true;
  #lanuages.python.venv.requirements = "requirements.txt";

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
