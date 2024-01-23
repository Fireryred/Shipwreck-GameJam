extends Node2D

@onready var shoot_position := $ShootPosition
@onready var cannon := $Cannon
@onready var hook := $Hook
@export var cannon_firerate := .5

const CANNON = "Cannon"
const HOOK = "Hook"

var cannon_ball_scene := preload("res://Scenes/cannonball.tscn")
var hook_scene := preload("res://Scenes/hook.tscn")

var hook_duration := .65
var is_left_click_hold := false
var is_delay_over := true
var bullet_type := "Cannon"

func _process(delta):
	look_at(get_global_mouse_position())
	if (is_left_click_hold && is_delay_over):
		_shoot()

func _unhandled_input(event):
	if event.is_action_pressed("key_q"):
		_switch_weapon()
		
	if event.is_action_pressed("left_click"):
		is_left_click_hold = true
	elif event.is_action_released("left_click"):
		is_left_click_hold = false

func _switch_weapon():
	if bullet_type == CANNON:
		bullet_type = HOOK
		cannon.visible = false
		hook.visible = true
	elif bullet_type == HOOK:
		bullet_type = CANNON
		cannon.visible = true
		hook.visible = false

func _shoot():
	_add_bullet(bullet_type)

func _add_bullet(bullet_type: String):
	var bullet
	if bullet_type == CANNON:
		bullet = cannon_ball_scene.instantiate()
		_spawn_bullet(bullet)
		_add_delay(cannon_firerate)
	elif bullet_type == HOOK:
		bullet = hook_scene.instantiate()
		_spawn_hook(bullet)
		
func _spawn_hook(bullet: Node2D):
	is_delay_over = false
	_spawn_bullet(bullet)
	await get_tree().create_timer(hook_duration).timeout
	_retract_hook(bullet)

func _spawn_bullet(bullet: Node2D):
	bullet.position = shoot_position.global_position
	bullet.direction = global_position.direction_to(get_global_mouse_position())
	add_child(bullet)

func _add_delay(duration: float):
	is_delay_over = false
	await get_tree().create_timer(duration).timeout
	is_delay_over = true

func _retract_hook(bullet: Node2D):
	bullet.is_retracted = true
