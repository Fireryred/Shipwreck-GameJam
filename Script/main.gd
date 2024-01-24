extends Node2D

@onready var play_button_ui := $MenuStick/AnimationPlayer

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_pressed():
	pass
	#get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/dialogue.tscn")


func _on_play_mouse_entered():
	play_button_ui.play("Hover Play")

func _on_play_mouse_exited():
	play_button_ui.stop(true)

func _on_credits_mouse_entered():
	play_button_ui.play("Hover Credit")

func _on_credits_mouse_exited():
	play_button_ui.stop(true)

func _on_quit_mouse_entered():
	play_button_ui.play("Hover Quit")
