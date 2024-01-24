extends Node2D

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
		"Score": 200
	},
	"Red" : {
		"Type": "Red",
		"Frequency" : 25,
		"Score": 400
	},
	"Luck" : {
		"Type": "Luck",
		"Frequency" : 10,
		"State": false
	},
	"Health" : {
		"Type": "Health",
		"Frequency" : 30,
		"Total": 5
	}
}

func _ready():
	_determine_drop()
	if drop == null:
		queue_free()

func _physics_process(delta):
	if is_detected:
		var ship = get_node("../Ship")
		direction = (ship.position - position).normalized()
		position += direction * 600 * delta

func _determine_drop():
	var prob := randi_range(1, 100)
	if (prob < drop_data.Luck.Frequency):
		drop = drop_data.Luck
		Type.play("Luck")
	elif (prob < drop_data.Red.Frequency):
		drop = drop_data.Red
		Type.play("Red")
	elif (prob < drop_data.Health.Frequency):
		drop = drop_data.Health
		Type.play("Health")
	elif (prob < drop_data.Green.Frequency):
		drop = drop_data.Green
		Type.play("Green")
	elif (prob < drop_data.Blue.Frequency):
		drop = drop_data.Blue
		Type.play("Blue")

func _on_area_entered(area):
	is_detected = true
	print(area.name)
	if (area.name == "ShipCollection"):
		queue_free()
