extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@export var max_speed = 50 
@export_range(0, 10, 0.1) var drag_factor := 0.1

var treasure
var ship
var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var onCollide = false
var damage = randf_range(0, .5)
var ohko = randf_range(0, 100)#if ohko > .01

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
	_spawn_treasure()
	queue_free()

func _spawn_treasure():
	var treasure_instance = treasure.instantiate()
	treasure_instance.position = position
	get_parent().add_child(treasure_instance, true)
