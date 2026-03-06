{ ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "imaro56";
    settings.user.email = "dimamarich07@gmail.com";
    includes = [{
      condition = "gitdir:~/work/";
      contents.user = {
        name = "Dima Marych";
        email = "imaro56@newtonideas.com";
      };
    }];
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519_personal";
      };
      "git.newtonideas.com" = {
        hostname = "git.newtonideas.com";
        identityFile = "~/.ssh/id_rsa";
      };
    };
  };
}
