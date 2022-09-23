{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager  = "delta";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool          = "vim_mergetool";
    };
    mergetool."vim_mergetool" = {
      cmd    = "nvim -f -c \"MergetoolStart\" \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"";
      prompt = false;
    };
    pull.rebase = false;
    push.autoSetupRemote = true;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
      "https://gitlab.com/".insteadOf = "gl:";
      "ssh://git@gitlab.com".pushInsteadOf = "gl:";
    };
  };

  rg = "${pkgs.ripgrep}/bin/rg";
in
{
  programs.git = {
    enable = true;
    aliases = {
      amend = "commit --amend -m";
      fixup = "!f(){ git reset --soft HEAD~\${1} && git commit --amend -C HEAD; };f";
      loc   = "!f(){ git ls-files | ${rg} \"\\.\${1}\" | xargs wc -l; };f"; # lines of code
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      pso = "push origin";
      plo = "pull origin main";
    };
    extraConfig = gitConfig;
    ignores = [
      "*.bloop"
      "*.bsp"
      "*.metals"
      "*.metals.sbt"
      "*metals.sbt"
      "*.direnv"
      "*.envrc"        # there is lorri, nix-direnv & simple direnv; let people decide
      "*hie.yaml"      # ghcide files
      "*.mill-version" # used by metals
      "*.jvmopts"      # should be local to every project
    ];
#    signing = {
#      key = "121D4302A64B2261";
#      signByDefault = true;
#    };
    userEmail = "k@gmail.com";
    userName = "kosumi";
  };
}
