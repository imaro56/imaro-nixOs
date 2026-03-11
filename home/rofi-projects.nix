{ pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";

  csbokDir = "/home/imaro56/work/code/CSBOK";
  csbokAppDir = "${csbokDir}/csbok";

  mdbDir = "/home/imaro56/work/code/MDB";

  # Helper: close all windows on a workspace
  closeWorkspace = ws: ''
    hyprctl clients -j | \
      ${jq} -r '.[] | select(.workspace.id == ${toString ws}) | .address' | \
      while read -r addr; do
        hyprctl dispatch closewindow "address:$addr"
      done
  '';

  launchWork = pkgs.writeShellScript "launch-work" ''
    hyprctl dispatch exec "[workspace 1 silent]" zeditor
    hyprctl dispatch exec "[workspace 2 silent]" slack
    hyprctl dispatch workspace 1
  '';

  killWork = pkgs.writeShellScript "kill-work" ''
    ${closeWorkspace 1}
    ${closeWorkspace 2}
    ${closeWorkspace 4}
  '';

  launchCsbok = pkgs.writeShellScript "launch-csbok" ''
    # Stop all running docker containers
    running=$(docker ps -q)
    if [ -n "$running" ]; then
      docker stop $running
    fi

    # Start project docker services
    docker compose -f "${csbokDir}/docker-compose.yml" up -d

    hyprctl dispatch exec "[workspace 3 silent]" "ghostty -e bash -c \"cd '${csbokDir}' && claude\""
    hyprctl dispatch exec "[workspace 9 silent]" "ghostty --working-directory=${csbokAppDir} -e fish -c 'python manage.py runserver'"
    hyprctl dispatch exec "[workspace 9 silent]" "ghostty --working-directory=${csbokAppDir}"
    hyprctl dispatch workspace 3
  '';

  killCsbok = pkgs.writeShellScript "kill-csbok" ''
    ${closeWorkspace 3}
    ${closeWorkspace 9}
    docker compose -f "${csbokDir}/docker-compose.yml" down
  '';

  launchMdb = pkgs.writeShellScript "launch-mdb" ''
    # Stop all running docker containers
    running=$(docker ps -q)
    if [ -n "$running" ]; then
      docker stop $running
    fi

    # Start project docker services
    docker compose -f "${mdbDir}/docker-compose.yml" up -d

    hyprctl dispatch exec "[workspace 3 silent]" "ghostty -e bash -c \"cd '${mdbDir}' && claude\""
    hyprctl dispatch exec "[workspace 9 silent]" "ghostty --working-directory=${mdbDir} -e fish -c 'python manage.py runserver'"
    hyprctl dispatch exec "[workspace 9 silent]" "ghostty --working-directory=${mdbDir}/frontend -e fish -c 'npm run dev'"
    hyprctl dispatch exec "[workspace 9 silent]" "ghostty --working-directory=${mdbDir}"
    hyprctl dispatch workspace 3
  '';

  killMdb = pkgs.writeShellScript "kill-mdb" ''
    ${closeWorkspace 3}
    ${closeWorkspace 9}
    docker compose -f "${mdbDir}/docker-compose.yml" down
  '';

  projectsScript = pkgs.writeShellScript "rofi-projects-mode" ''
    if [ "$ROFI_RETV" -eq 0 ]; then
      echo -en "\0prompt\x1fProject\n"
      echo -en "\0no-custom\x1ftrue\n"
      echo -en "Work Run\0icon\x1fmedia-playback-start\x1finfo\x1fwork-run\n"
      echo -en "Work Kill\0icon\x1fprocess-stop\x1finfo\x1fwork-kill\n"
      echo -en "CSBOK Run\0icon\x1fmedia-playback-start\x1finfo\x1fcsbok-run\n"
      echo -en "CSBOK Kill\0icon\x1fprocess-stop\x1finfo\x1fcsbok-kill\n"
      echo -en "MDB Run\0icon\x1fmedia-playback-start\x1finfo\x1fmdb-run\n"
      echo -en "MDB Kill\0icon\x1fprocess-stop\x1finfo\x1fmdb-kill\n"
    elif [ "$ROFI_RETV" -eq 1 ]; then
      case "$ROFI_INFO" in
        work-run)   coproc ( ${launchWork} & ) ;;
        work-kill)  coproc ( ${killWork} & ) ;;
        csbok-run)  coproc ( ${launchCsbok} & ) ;;
        csbok-kill) coproc ( ${killCsbok} & ) ;;
        mdb-run)    coproc ( ${launchMdb} & ) ;;
        mdb-kill)   coproc ( ${killMdb} & ) ;;
      esac
    fi
  '';
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER SHIFT, D, exec, rofi -show projects -modi 'projects:${projectsScript}' -theme-str 'window {width: 400px;} listview {lines: 8;}'"
  ];
}
