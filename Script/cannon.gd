extends Node2D

@onready var shoot_position = $ShootPosition

var cannon_ball_scene := preload("res://Scenes/cannonball.tscn")

var is_left_click_hold := false


func _process(delta):
	look_at(get_global_mouse_position())
	if (is_left_click_hold):
		_shoot()

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		is_left_click_hold = true
	elif event.is_action_released("left_click"):
		is_left_click_hold = false

func _shoot():
	var bullet := cannon_ball_scene.instantiate()
	bullet.position = shoot_position.global_position
	bullet.direction = global_position.direction_to(get_global_mouse_position())
	add_child(bullet)
