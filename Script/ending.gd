extends Node2D

@onready var play_again_button_ui := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_button_mouse_entered():
	play_again_button_ui.play("Button Hover")


func _on_play_again_button_mouse_exited():
	play_again_button_ui.stop(true)


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
