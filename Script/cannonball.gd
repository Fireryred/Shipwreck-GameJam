extends Node2D

@export var speed := 600
@export var lifetime := 2

var direction := Vector2.ZERO
var starting_pos := Vector2.ZERO

func _ready():
	top_level = true
	look_at(position + direction)
	get_node("Lifetime").wait_time = lifetime
	get_node("Lifetime").start()

func _physics_process(delta):
	position += direction * speed * delta

func _on_cannon_hitbox_area_entered(area):
	queue_free()

func _on_lifetime_timeout():
	queue_free()
