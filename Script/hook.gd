extends Node2D

@export var speed := 600

@onready var Duration := $Duration
@onready var Status := $Hook

var direction := Vector2.ZERO
var duration := 1
var is_retracted := false
var ship

func _ready():
	Duration.wait_time = duration
	top_level = true
	look_at(position + direction)
	Status.play("Open")

func _physics_process(delta):
	ship = get_node("../../../Ship")
	if is_retracted:
		direction = (ship.position - position).normalized()
		position += direction * speed * delta
		look_at(position - direction)
	else:
		position += direction * speed * delta
		
func _on_hook_hurtbox_area_entered(area):
	if (area.name == "ShipCollection"):
		get_parent().is_delay_over = true
		queue_free()
	else:
		Status.play("Close")
		is_retracted = true

func _on_duration_timeout():
	is_retracted = true
