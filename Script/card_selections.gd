extends Control

@onready var ScoreUP := $"Scroll/Random Powerup/Score UP"
@onready var LuckUP := $"Scroll/Random Powerup/Luck UP"
@onready var HealthUP := $"Scroll/Random Powerup/HealthUp"

var type := ""
var hp := Game.playerHp
var power_up := Game.power_up

func _ready():
	_reset()
	random_card()

func _reset():
	ScoreUP.visible = false
	LuckUP.visible = false
	HealthUP.visible = false

func random_card():
	var prob = randi_range(1, 3)
	_reset()
	match prob:
		1:
			ScoreUP.visible = true
			type = "score"
		2:
			LuckUP.visible = true
			type = "luck"
		3:
			HealthUP.visible = true
			type = "health"

func _process(delta):
	pass

func _on_scroll_pressed():
	print(type)
	match type:
		"score":
			power_up.Score += 1
		"luck":
			power_up.Luck += 1
		"health":
			power_up.Health += 1
			hp += 25
		
	Game._add_wave(hp)
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
