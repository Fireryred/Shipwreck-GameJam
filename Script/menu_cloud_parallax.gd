extends ParallaxBackground

var cloud_speed = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= cloud_speed * delta
	
