{pkgs, ...}: {
  programs.fzf = let
    fd = "${pkgs.fd}/bin/fd";
  in {
    enable = true;
    changeDirWidgetCommand = "${fd} --type d";
    changeDirWidgetOptions = ["--preview '${pkgs.tree}/bin/tree -I node_modules -C {} | head -200'"];
    defaultCommand = "${fd} --type f --type l";
  };
}
