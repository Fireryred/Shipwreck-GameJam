extends Area2D

@onready var Blue := $Blue
@onready var Green := $Green
@onready var Health:= $Health
@onready var Red := $Red
@onready var Luck := $Luck
@onready var Type := $Drops

var direction := Vector2.ZERO 
var is_detected := false

var drop
var drop_data := {
	"Green" : {
		"Type": "Green",
		"Frequency": 70,
		"Score": 100
	},
	"Blue" : {
		"Type": "Blue",
		"Frequency" : 50,
		"Score": 100
	},
	"Red" : {
		"Type": "Red",
		"Frequency" : 25,
		"Score": 100
	},
	"Luck" : {
		"Type": "Luck",
		"Frequency" : 10,
		"Score": 100
	},
	"Health" : {
		"Type": "Health",
		"Frequency" : 30,
		"Score": 100
	}
}

func _ready():
	_determine_drop()
	if drop != null:
		_disable_collisions()
		_spawn_treasure()
	else:
		queue_free()

func _physics_process(delta):
	if is_detected:
		var ship = get_node("../Ship")
		direction = (ship.position - position).normalized()
		position += direction * 600 * delta

func _spawn_treasure():
	if (drop.Type == Blue.name):
		get_node("Blue").disabled = false
		Type.play("Blue")
	elif (drop.Type == Green.name):
		get_node("Green").disabled = false
		Type.play("Green")
	elif (drop.Type == Red.name):
		get_node("Red").disabled = false
		Type.play("Red")
	elif (drop.Type == Health.name):
		get_node("Health").disabled = false
		Type.play("Health")
	elif (drop.Type == Luck.name):
		get_node("Luck").disabled = false
		Type.play("Luck")

func _disable_collisions():
	Blue.disabled = true
	Green.disabled = true
	Red.disabled = true
	Health.disabled = true
	Luck.disabled = true

func _determine_drop():
	var prob := randi_range(1, 100)
	if (prob < drop_data.Luck.Frequency):
		drop = drop_data.Luck
	elif (prob < drop_data.Red.Frequency):
		drop = drop_data.Red
	elif (prob < drop_data.Health.Frequency):
		drop = drop_data.Health
	elif (prob < drop_data.Green.Frequency):
		drop = drop_data.Green
	elif (prob < drop_data.Blue.Frequency):
		drop = drop_data.Blue

func _on_area_entered(area):
	is_detected = true
	print(area.name)
	if (area.name == "ShipCollection"):
		queue_free()
