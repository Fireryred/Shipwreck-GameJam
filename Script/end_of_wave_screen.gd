extends Control

func _unhandled_input(event):
	if event.is_action_pressed("left_click") and visible:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/card_select.tscn")
