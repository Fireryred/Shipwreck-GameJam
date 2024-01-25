extends CharacterBody2D

@onready var state := $AnimatedSprite2D
@onready var hitbox := $TorpedoHitbox/CollisionShape2D
@onready var ship := $"../Ship"
@onready var anim := $AnimationPlayer
@export var max_speed := 10000
@export var acceleration := 25
@export var lifetime := 5
@export_range(0, 10, 0.1) var drag_factor := 0.1

var treasure
var speed := 0
var angle := Vector2.ZERO
var direction := Vector2.ZERO
var is_hurt := false

func _ready():
	state.play("Idle")
	get_node("Lifetime").wait_time = lifetime
	get_node("Lifetime").start()
	angle = position.direction_to(ship.position)
	anim.play("Laser")
	

func _physics_process(delta):
	#Acceleration
	speed += acceleration
	velocity = angle * min(speed, max_speed)
	
	#rotate to direction
	rotation = velocity.angle()
	queue_redraw()
	move_and_slide()

func _set_marker():
	pass


func _on_torpedo_collision_body_entered(body):
	if body.name == "Ship":
		if (is_hurt):
			body.health -= .012 * speed
		else: 
			body.health -= .02 * speed
		queue_free()

func _on_torpedo_hurtbox_area_entered(area):
	if (is_hurt):
		queue_free()
		_spawn_treasure()
	else:
		hitbox.shape.height = 1000
		state.play("Hurt")
		is_hurt = true

func _on_lifetime_timeout():
	ship.score += 500
	queue_free()

func _spawn_treasure():
	var treasure_instance = treasure.instantiate()
	treasure_instance.position = position
	get_parent().add_child(treasure_instance, true)
