extends Label

@onready var wave_timer := $"../../WaveTimer"
@onready var wave_label := $"../../Wave"

func _process(delta):
	text = str(int(wave_timer.time_left))
	wave_label.text = str(Game.wave)
