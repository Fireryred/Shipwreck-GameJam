extends CharacterBody2D

@export var max_speed := 300
@export_range(0, 10, 0.1) var drag_factor := .1
@onready var luck_timer := $LuckTimer
@onready var hook := $Cannon/Hook
@onready var shooting_pos := $Cannon/ShootPosition

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO


var drop
var power_up
var max_health := Game.playerHp
var health := Game.playerHp
var score := Game.score
var is_lucky := true

func _ready():
	power_up = Game.power_up

func _physics_process(delta):
	#get input
	var direction = Input.get_vector("left", "right", "up", "down")
	#movement speed
	desired_velocity = direction * max_speed
	
	#Smooth turns
	steering_velocity = desired_velocity - velocity
	velocity += steering_velocity * drag_factor
	
	#rotate to direction
	rotation = velocity.angle()
	_save_game()
	move_and_slide()

func _save_game():
	Game.playerHp = health
	Game.score = score

func _calculate_score():
	if drop != null:
		if drop.Type == "Luck":
			luck_timer.wait_time = 3 + (power_up.Luck * .1)
			luck_timer.start()
		elif drop.Type == "Health":
			health += max_health * .05
		else:
			score += (drop.Score + (power_up.Score * 200))* ((2 if is_lucky else 1) + power_up.Luck)

func _on_luck_timer_timeout():
	is_lucky = false
	luck_timer.stop()
