extends Node2D

@export var speed := 600

@onready var Duration := $Duration
@onready var Status := $Hook
@onready var shoot_position := $"../ShootPosition"

var direction := Vector2.ZERO
var duration := 1
var is_retracted := false
var has_exited_ship := false

func _ready():
	Duration.wait_time = duration
	top_level = true
	look_at(position + direction)
	Status.play("Open")

func _physics_process(delta):
	if is_retracted:
		direction = (shoot_position.global_position - position).normalized()
		position += direction * speed * delta
		look_at(position - direction)
	else:
		position += direction * speed * delta
		
func _on_hook_hurtbox_area_entered(area):
	if area.name == "Treasure":
		Status.play("Close")
		is_retracted = true
	elif has_exited_ship or is_retracted:
		if (area.name == "ShipCollection"):
			get_parent().is_delay_over = true
			queue_free()

func _on_duration_timeout():
	is_retracted = true

func _on_hook_hurtbox_area_exited(area):
	if area.name == "ShipHurtbox":
		has_exited_ship = true
