extends Node

var playerHp := 100
var wave := 1
var score := 0
var power_up := {
	"Score" : 0,
	"Luck" : 0,
	"Health" : 0
}

func _reset():
	playerHp = 100
	wave = 1
	score = 0

func _add_wave(max_hp: int):
	wave += 1
	playerHp = max_hp

func _add_powerup(type: String):
	match type:
		"score":
			power_up.Score += 1
		"luck":
			power_up.Luck += 1
		"Health":
			power_up.Health += 1
