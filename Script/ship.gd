extends CharacterBody2D

@export var top_speed := 300.0
@export_range(0, 10, 0.1) var drag_factor := 0.1

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO

func _physics_process(delta):
	#get input
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#movement speed
	desired_velocity = direction * top_speed
	
	#Smooth turns
	steering_velocity = desired_velocity - velocity
	velocity += steering_velocity * drag_factor
	#rotate to direction
	rotation = velocity.angle()
	move_and_slide()
