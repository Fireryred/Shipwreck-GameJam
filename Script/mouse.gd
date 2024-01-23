extends AnimatedSprite2D

func _ready():
	visible = false

func _physics_process(delta):
	position = get_global_mouse_position()

func _on_area_2d_area_entered(area):
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	visible = true
	play("Enemy")

func _on_area_2d_area_exited(area):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = false
	stop()
	
