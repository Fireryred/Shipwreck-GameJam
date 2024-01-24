extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
@export var max_speed = 150
@export_range(0, 10, 0.1) var drag_factor := 0.1

var player
var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var onCollide = false
var health = 2

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

func _set_ship_state():
	if(health == 2):
		health -= 1
		anim.play("Hurt1")
	elif(health == 1):
		health -= 1
		anim.play("Hurt2")
	else:
		queue_free()

func _on_tank_hitbox_body_entered(body):
	if body.name == "Ship":
		onCollide = true
		body.health -= 5*health

func _on_tank_hurtbox_area_entered(area):
	if area.name == "CannonBall":
		_set_ship_state()

func _on_tank_hitbox_area_exited(area):
	if area.name == "ShipHurtbox":
		onCollide = false
