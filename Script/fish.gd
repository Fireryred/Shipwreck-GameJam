extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
@export var max_speed = 50
@export_range(0, 10, 0.1) var drag_factor := 0.1

var player
var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var onCollide = false

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	player = get_node("../Ship")
	if !onCollide:
		var direction = (player.position - self.position).normalized()
		
		desired_velocity = direction * max_speed
		
		#Smooth turns
		steering_velocity = desired_velocity - velocity
		velocity += steering_velocity * drag_factor
		
		#rotate to direction
		rotation = velocity.angle()
		move_and_slide()

func _on_fish_hitbox_entered(body):
	player = get_node("../Ship")
	if body.name == "Ship":
		velocity = -velocity.normalized() * 500
		body.health -= .5
		onCollide = true
	move_and_slide()
		
func _on_fish_hitbox_exited(body):
	onCollide = false
	velocity = velocity.normalized()
	move_and_slide()
	
