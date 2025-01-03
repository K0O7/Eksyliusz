extends AnimatedSprite2D
#
#@export 
## Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass # Replace with function body.
#
#
func _input(_event):
	position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("LMB_click"):
		play("Click")
