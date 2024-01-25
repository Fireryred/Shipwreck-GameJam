extends Node

var playerHp := 100
var wave := 1
var score := 0

func _reset():
	playerHp = 100
	wave = 1
	score = 0

func _add_wave(max_hp: int):
	wave += 1
	playerHp = max_hp
