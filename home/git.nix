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
}
