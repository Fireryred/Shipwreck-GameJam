extends ProgressBar

@onready var ship = $"../Ship"

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = ship.max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = ship.health
