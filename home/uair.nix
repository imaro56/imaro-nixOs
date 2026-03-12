{ pkgs, ... }:

{
  systemd.user.services.uair = {
    Unit = {
      Description = "uair pomodoro timer daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/rm -f %t/uair.sock";
      ExecStart = "${pkgs.uair}/bin/uair";
      Restart = "always";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."uair/uair.toml".text = ''
    [defaults]
    format = "{time}\n"
    time_format = "%M:%S"
    paused_state_text = "paused"
    resumed_state_text = "resumed"

    [[sessions]]
    id = "work"
    name = "Work"
    duration = "25m"
    command = "notify-send 'uair' 'Take a break!' && watson stop"
    autostart = false

    [[sessions]]
    id = "rest"
    name = "Rest"
    duration = "5m"
    command = "notify-send 'uair' 'Back to work!' && watson restart"
    autostart = false

    [[sessions]]
    id = "long-rest"
    name = "Long Rest"
    duration = "15m"
    command = "notify-send 'uair' 'Back to work!' && watson restart"
    autostart = false
  '';
}
