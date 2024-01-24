extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
@export var max_speed = 50
@export_range(0, 10, 0.1) var drag_factor := 0.1

var ship
var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var onCollide = false
var damage = randf_range(0, .5)

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	ship = get_node("../Ship")
	if !onCollide:
		var direction = (ship.position - self.position).normalized()
		
		desired_velocity = direction * max_speed
		
		#Smooth turns
		steering_velocity = desired_velocity - velocity
		velocity += steering_velocity * drag_factor
		
		#rotate to direction
		rotation = velocity.angle()
		move_and_slide()

func _on_fish_hitbox_entered(body):
	ship = get_node("../Ship")
	if body.name == "Ship":
		velocity = -velocity.normalized() * 500
		body.health -= damage
		onCollide = true
	move_and_slide()
		
func _on_fish_hitbox_exited(body):
	onCollide = false
	velocity = velocity.normalized()
	move_and_slide()

func _on_fish_hurtbox_area_entered(area):
	queue_free()
