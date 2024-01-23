extends Node2D

@export var speed := 600

var direction := Vector2.ZERO
var is_retracted := false
var ship

func _ready():
	top_level = true
	look_at(position + direction)

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
