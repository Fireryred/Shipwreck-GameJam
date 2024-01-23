extends Node2D

@export var speed := 600

var direction := Vector2.ZERO

func _ready():
	top_level = true
	look_at(position + direction)

func _physics_process(delta):
	position += direction * speed * delta

func _on_cannon_hitbox_area_entered(area):
	queue_free()
