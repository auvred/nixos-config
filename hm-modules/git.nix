{...}: {
  programs.git = {
    enable = true;
    aliases = {
      "lg" = "log --graph --pretty=format:'%C(magenta)%h%Creset %C(bold cyan)%d%C(reset) %s - %Cgreen%cr by %an%Creset' --abbrev-commit --date=relative";
      "clone-shallow" = "clone --depth 1 --single-branch";
    };
    includes = [
      {
        condition = "gitdir:~/dev/personal/github/**";
        contents = {
          gpg.format = "ssh";
          commit.gpgsign = true;
          tag.gpgsign = true;
          core.sshCommand = "ssh -i ~/.ssh/id_ed25519_auvred_github";
          user = {
            signingkey = "~/.ssh/id_ed25519_auvred_sign.pub";
            name = "auvred";
            email = "aauvred@gmail.com";
          };
        };
      }
    ];
  };
}
