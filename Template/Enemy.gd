extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
@export var max_speed = 50
@export_range(0, 10, 0.1) var drag_factor := 0.1

var player
var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	player = get_node("../Ship")
	var direction = (player.position - self.position).normalized()
	
	desired_velocity = direction * max_speed
	
	#Smooth turns
	steering_velocity = desired_velocity - velocity
	velocity += steering_velocity * drag_factor
	
	#rotate to direction
	rotation = velocity.angle()
	move_and_slide()
