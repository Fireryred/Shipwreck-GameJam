extends Node2D

@onready var shoot_position := $ShootPosition
@export var firerate := 1.0

var cannon_ball_scene := preload("res://Scenes/cannonball.tscn")

var is_left_click_hold := false
var is_delay_over := true

func _process(delta):
	look_at(get_global_mouse_position())
	if (is_left_click_hold && is_delay_over):
		_shoot()

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		is_left_click_hold = true
	elif event.is_action_released("left_click"):
		is_left_click_hold = false

func _shoot():
	_add_bullet()
	_add_delay()

func _add_bullet():
	var bullet := cannon_ball_scene.instantiate()
	bullet.position = shoot_position.global_position
	bullet.direction = global_position.direction_to(get_global_mouse_position())
	add_child(bullet)

func _add_delay():
	is_delay_over = false
	await get_tree().create_timer(firerate).timeout
	is_delay_over = true
