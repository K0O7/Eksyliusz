extends Camera2D

@export var SPEED: int = 10
@export var smoothing_speed: float = 10.
@export var left_limit: int = -100000
@export var right_limit: int = 100000
@export var top_limit: int = -100000
@export var bottom_limit: int = 100000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = smoothing_speed
	limit_bottom = bottom_limit
	limit_left = left_limit
	limit_right = right_limit
	limit_top = top_limit
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var h_dir := Input.get_axis("camera_left", "camera_right")
	if h_dir:
		global_position.x += h_dir * SPEED
	var v_dir := Input.get_axis("camera_up", "camera_down")
	if v_dir:
		global_position.y += v_dir * SPEED
	
