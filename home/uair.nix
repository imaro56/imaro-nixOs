{ ... }:

{
  xdg.configFile."uair/uair.toml".text = ''
    [defaults]
    format = "{time}\n"
    time_format = "%M:%S"
    paused_state_text = "paused"
    resumed_state_text = "resumed"

    [[sessions]]
    id = "work"
    name = "Work"
    duration = "50m"
    command = "notify-send 'uair' 'Take a break!' && watson stop"
    autostart = false

    [[sessions]]
    id = "rest"
    name = "Rest"
    duration = "10m"
    command = "notify-send 'uair' 'Back to work!'"
    autostart = false
  '';
}
