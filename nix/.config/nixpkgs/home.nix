{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = (builtins.getEnv "USER");
  home.homeDirectory = (builtins.getEnv "HOME");

  # Set man pages according to
  # https://github.com/nix-community/home-manager/issues/432#issuecomment-434817038
  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  home.sessionVariables = {
    LANG = "en_AU.UTF-8";
  };

  home.packages = [
    pkgs.argo
    pkgs.argocd
    pkgs.asdf
    pkgs.bat
    (pkgs.linkFarm "bazel" [ {
      name = "bin/bazel";
      path = "${pkgs.bazelisk}/bin/bazelisk";
    } ])
    pkgs.bazelisk
    pkgs.cue
    pkgs.direnv
    pkgs.fzf
    pkgs.gh
    pkgs.git-crypt
    pkgs.gocode
    pkgs.goreleaser
    pkgs.jq
    pkgs.kapp
    pkgs.kind
    pkgs.procs
    pkgs.proselint
    pkgs.qbec
    pkgs.ripgrep
    pkgs.rust-analyzer
    pkgs.starship
    pkgs.stern
    pkgs.stow
    pkgs.tealdeer
    pkgs.tektoncd-cli
    pkgs.tokei
    pkgs.tree
    pkgs.vendir
    pkgs.yq
    pkgs.xkeysnail
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
