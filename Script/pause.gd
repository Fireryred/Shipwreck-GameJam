extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _handle_pause():
	get_tree().paused = not get_tree().paused
	show() if get_tree().paused else hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_handle_pause()

func _on_resume_pressed():
	_handle_pause()
