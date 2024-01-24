extends Sprite2D

@onready var key_timer := $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	key_timer.wait_time = 1000
	visible = true

func _on_timer_timeout():
		visible = false
