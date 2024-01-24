extends CharacterBody2D

@onready var state = get_node("AnimatedSprite2D")
@onready var hitbox := $TorpedoHitbox/CollisionShape2D
@export var max_speed := 10000
@export var acceleration := 25
@export var lifetime := 5
@export_range(0, 10, 0.1) var drag_factor := 0.1

var treasure
var player 
var speed := 0
var angle := Vector2.ZERO
var is_hurt := false

func _ready():
	state.play("Idle")
	player = get_node("../Ship")
	get_node("Lifetime").wait_time = lifetime
	get_node("Lifetime").start()
	angle = global_position.direction_to(player.position)
	
func _physics_process(delta):
	#Acceleration
	speed += acceleration
	velocity = angle * min(speed, max_speed)
	
	#rotate to direction
	rotation = velocity.angle()
	move_and_slide()
	
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
	else:
		hitbox.shape.height = 1000
		state.play("Hurt")
		is_hurt = true

func _on_lifetime_timeout():
	_spawn_treasure()
	queue_free()

func _spawn_treasure():
	var treasure_instance = treasure.instantiate()
	treasure_instance.position = position
	get_parent().add_child(treasure_instance, true)
