extends AnimatedSprite2D

var switch := false

func _ready():
	visible = false

func _physics_process(delta):
	position = get_global_mouse_position()

func _input(event):
	if event.is_action_pressed("key_q"):
		switch = not switch
		play("Treasure") if switch else play("Enemy")
		

func _on_area_2d_area_entered(area):
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	visible = true

func _on_area_2d_area_exited(area):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = false
	stop()
	
