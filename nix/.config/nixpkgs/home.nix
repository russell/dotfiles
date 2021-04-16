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

  home.packages = [
    pkgs.argo
    pkgs.argocd
    pkgs.asdf
    (pkgs.linkFarm "bazel" [ {
      name = "bin/bazel";
      path = "${pkgs.bazelisk}/bin/bazelisk";
    } ])
    pkgs.bazelisk
    pkgs.direnv
    pkgs.fzf
    pkgs.gh
    pkgs.git-crypt
    pkgs.goreleaser
    pkgs.jq
    pkgs.kapp
    pkgs.proselint
    pkgs.qbec
    pkgs.ripgrep
    pkgs.rust-analyzer
    pkgs.stern
    pkgs.stow
    pkgs.tektoncd-cli
    pkgs.tree
    pkgs.yq
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
