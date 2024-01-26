extends Node2D

@onready var play_button_ui := $MenuStick/AnimationPlayer
@onready var play_quit_ui := $MenuStick/QuitAnimation

@onready var background_animation := $Background/AnimationPlayer
@onready var title_animation := $TitleName/AnimationPlayer


func _ready():
	background_animation.play("Water Move")
	title_animation.play("Enter Title")

func _process(delta):
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_pressed():
	pass
	#get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func _on_play_mouse_entered():
	play_button_ui.play("Hover Play")

func _on_play_mouse_exited():
	play_button_ui.stop(false)

func _on_credits_mouse_entered():
	play_button_ui.play("Hover Credit")

func _on_credits_mouse_exited():
	play_button_ui.stop(false)

func _on_quit_mouse_entered():
	play_quit_ui.play("Hover Quit")
