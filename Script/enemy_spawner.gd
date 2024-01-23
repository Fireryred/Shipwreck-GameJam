extends Node2D

var fish := preload("res://Scenes/fish.tscn")
var torpedo := preload("res://Scenes/torpedo_ship.tscn")
var tank := preload("res://Scenes/tank_ship.tscn")

var enemy_data := {
	"Fish":{
		"Scene":fish,
		"Frequency":70 },#original:70
	"Torpedo":{
		"Scene":torpedo,
		"Frequency":40 },#original:40
	"Tank":{
		"Scene":tank,
		"Frequency":25 }#original:25
	,}

var wave = Game.wave

func _on_spawn_rate_timeout():
	var prob := randi_range(1, 100)
	if prob <= enemy_data.Tank.Frequency:
		prob = randi_range(1, 2)
		if prob == 1:
			_spawn_enemy(enemy_data.Tank)
	elif prob <= enemy_data.Torpedo.Frequency:
		_spawn_enemy(enemy_data.Torpedo)
	else:
		_spawn_enemy(enemy_data.Fish)
	get_child(0).wait_time = (randf_range(1, 2)) / (wave * .5)
	
func _spawn_enemy(enemy: Dictionary):
	var enemy_position = Vector2(randf_range(-124 ,1276), randf_range(-124, 772))
	
	while enemy_position.x < 1152 and enemy_position.x > 0 and enemy_position.y < 1152 and enemy_position.y > 0:
		enemy_position = Vector2(randf_range(-124 ,1276), randf_range(-124, 772))
	
	var enemy_instance = enemy.Scene.instantiate()
	enemy_instance.position = enemy_position
	
	get_parent().add_child(enemy_instance)
	
