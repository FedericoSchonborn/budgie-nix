{
  pkgs,
  budgie-desktop,
  ...
}: let
  mkBudgieExtras = import ./mkBudgieExtras.nix {inherit pkgs budgie-desktop;};
in {
  budgie-app-launcher = mkBudgieExtras {name = "app-launcher";};
  budgie-applications-menu = mkBudgieExtras {name = "applications-menu";};
  budgie-brightness-controller = mkBudgieExtras {name = "brightness-controller";};
  budgie-fuzzyclock = mkBudgieExtras {name = "fuzzyclock";};
  budgie-kangaroo = mkBudgieExtras {name = "kangaroo";};
  budgie-keyboard-autoswitch = mkBudgieExtras {name = "keyboard-autoswitch";};
  budgie-network-manager = mkBudgieExtras {name = "network-manager";};
  budgie-quicknote = mkBudgieExtras {name = "quicknote";};
  budgie-rotation-lock = mkBudgieExtras {name = "rotation-lock";};
  budgie-trash = mkBudgieExtras {name = "trash";};
  budgie-workspace-stopwatch = mkBudgieExtras {
    name = "workspace-stopwatch";
    flag = "workspacestopwatch";
  };

  # FIXME: PermissionError: [Errno 13] Permission denied: '/usr'
  # budgie-clockworks = mkBudgieExtras {name = "clockworks";};
  # budgie-countdown = mkBudgieExtras {name = "countdown";};
  # budgie-dropby = mkBudgieExtras {name = "dropby";};
  # budgie-hotcorners = mkBudgieExtras {name = "hotcorners";};
  # budgie-quickchar = mkBudgieExtras {name = "quickchar";};
  # budgie-recentlyused = mkBudgieExtras {name = "recentlyused";};
  # budgie-showtime = mkBudgieExtras {name = "showtime";};
  # budgie-takeabreak = mkBudgieExtras {name = "takeabreak";};
  # budgie-visualspace = mkBudgieExtras {name = "visualspace";};
  # budgie-wallstreet = mkBudgieExtras {name = "wallstreet";};
  # budgie-weathershow = mkBudgieExtras {name = "weathershow";};
  # budgie-window-shuffler = mkBudgieExtras {name = "window-shuffler";};
  # budgie-wpreviews = mkBudgieExtras {name = "wpreviews";};
  # budgie-wswitcher = mkBudgieExtras {name = "wswitcher";};
}
