{ pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";

  csbokDir = "/home/imaro56/work/code/CSBOK";
  csbokAppDir = "${csbokDir}/csbok";

  # Helper: close all windows matching a hyprland window class
  closeByClass = class: ''
    hyprctl clients -j | \
      ${jq} -r '.[] | select(.class == "${class}") | .address' | \
      while read -r addr; do
        hyprctl dispatch closewindow "address:$addr"
      done
  '';

  launchWork = pkgs.writeShellScript "launch-work" ''
    # Workspace 1: Zed
    hyprctl dispatch workspace 1
    zeditor &
    sleep 0.3

    # Workspace 2: Slack
    hyprctl dispatch workspace 2
    slack &
    sleep 0.3

    # Workspace 4: Zen browser
    hyprctl dispatch workspace 4
    zen-beta &
    sleep 0.3

    hyprctl dispatch workspace 1
  '';

  killWork = pkgs.writeShellScript "kill-work" ''
    ${closeByClass "dev.zed.Zed"}
    ${closeByClass "Slack"}
    ${closeByClass "zen-beta"}
  '';

  launchCsbok = pkgs.writeShellScript "launch-csbok" ''
    # Stop all running docker containers
    running=$(docker ps -q)
    if [ -n "$running" ]; then
      docker stop $running
    fi

    # Start project docker services
    docker compose -f "${csbokDir}/docker-compose.yml" up -d

    # Workspace 3: Claude Code in project dir
    hyprctl dispatch workspace 3
    ghostty -e bash -c "cd '${csbokDir}' && claude" &
    sleep 0.4

    # Workspace 9: two terminals in csbok/csbok
    hyprctl dispatch workspace 9
    ghostty --working-directory="${csbokAppDir}" &
    sleep 0.4
    ghostty --working-directory="${csbokAppDir}" &
    sleep 0.4

    # Focus workspace 3 (main work)
    hyprctl dispatch workspace 3
  '';

  killCsbok = pkgs.writeShellScript "kill-csbok" ''
    ${closeByClass "com.mitchellh.ghostty"}

    # Stop project docker services
    docker compose -f "${csbokDir}/docker-compose.yml" down
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
        mdb-*)      coproc ( notify-send "MDB" "Not configured yet" & ) ;;
      esac
    fi
  '';
in
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER SHIFT, D, exec, rofi -show projects -modi 'projects:${projectsScript}' -theme-str 'window {width: 400px;} listview {lines: 8;}'"
  ];
}
