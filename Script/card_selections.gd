extends Node

@onready var AttackUP := $"FirstScroll/Random Powerup/Attack UP"
@onready var LuckUP := $"FirstScroll/Random Powerup/Luck UP"

var rng = RandomNumberGenerator.new()
var HP = Game.playerHp

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func random_card(number:int):
	if number <= 70:
		pass
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
