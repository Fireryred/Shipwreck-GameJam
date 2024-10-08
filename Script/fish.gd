extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var ship = $"../Ship"
@export var max_speed = 50 
@export_range(0, 10, 0.1) var drag_factor := 0.1

var treasure
var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var onCollide = false
var damage = randf_range(0, .5)
var ohko = randf_range(0, 100)#if ohko > .01

func _ready():
	anim.play("Idle")

func _physics_process(_delta):
	if !onCollide:
		var direction = (ship.position - position).normalized()
		
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
		
func _on_fish_hitbox_exited(_body):
	onCollide = false
	velocity = velocity.normalized()
	move_and_slide()

func _on_fish_hurtbox_area_entered(_area):
	_spawn_treasure()
	queue_free()

func _spawn_treasure():
	ship.score += 50
	var treasure_instance = treasure.instantiate()
	treasure_instance.position = position
	get_parent().add_child(treasure_instance, true)
