extends AnimatedSprite2D

@onready var detect = $Area2D

var switch := false

func _ready():
	visible = false

func _physics_process(delta):
	position = get_global_mouse_position()

func _input(event):
	if event.is_action_pressed("key_q"):
		switch = not switch
		stop()

func _play_anim(name: String):
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	visible = true
	play("Treasure") if name == "Treasure" else play("Enemy")
	
func _on_area_2d_area_entered(area):
	if switch and area.name == "Treasure":
		_play_anim(area.name)
	elif not switch and area.name.contains("Hurtbox"):
		_play_anim(area.name)

func _on_area_2d_area_exited(area):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = false
	stop()
	
