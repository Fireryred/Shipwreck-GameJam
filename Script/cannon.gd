extends Node2D

@onready var shoot_position = $ShootPosition

var cannon_ball_scene := preload("res://Scenes/cannonball.tscn")


func _process(delta):
	look_at(get_global_mouse_position())

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		var bullet := cannon_ball_scene.instantiate()
		bullet.position = shoot_position.global_position
		bullet.direction = global_position.direction_to(get_global_mouse_position())
		add_child(bullet)
