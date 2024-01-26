extends Control

@onready var button_animation := $Panel/AnimationPlayer
@onready var quit_animation := $Panel/QuitAnimation
@onready var resume_button := $Panel/Resume

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _handle_pause():
	get_tree().paused = not get_tree().paused
	show() if get_tree().paused else hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_custom_mouse_cursor(null)
		_handle_pause()

func _on_resume_pressed():
	button_animation.play("Resume Press")
	_handle_pause()

func _on_resume_mouse_entered():
	button_animation.play("Resume Hover")

func _on_resume_mouse_exited():
	button_animation.stop(true)


func _on_quit_mouse_entered():
	button_animation.play("Quit Tremble")
	print("Quit Button Hover")

func _on_quit_mouse_exited():
	button_animation.stop(true)


func _on_quit_pressed():
	quit_animation.play("Quit Fall",)
	resume_button.disabled = true
	print("Button Pressed")


func _on_quit_animation_animation_finished(anim_name):
	if anim_name == "Quit Fall":
		get_tree().quit()
