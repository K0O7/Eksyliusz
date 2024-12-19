extends CharacterBody2D

@export var tilemap: TileMapLayer
@export var cell_size: int
@export var speed: int
@export var acceleration: int
@export var starting_pos: Vector2

@onready var navig_agent: NavigationAgent2D = $NavigationAgent2D

signal set_next_cell_sign

var adjus_to_cell = Vector2(cell_size, cell_size)
var target_pos: Vector2
var curr_pos: Vector2
var grid_diff: Vector2
var is_moving: bool = false
var direction: Vector2

func _ready():
	global_position = tilemap.map_to_local(starting_pos)
	target_pos = tilemap.local_to_map(global_position)
	set_next_cell_sign.connect(set_next_cell)


func _input(event):
	if Input.is_action_just_pressed("LMB_click"):
		target_pos = tilemap.local_to_map(get_global_mouse_position())
		curr_pos = tilemap.local_to_map(global_position)
		grid_diff = target_pos - curr_pos
		
		set_next_cell_sign.emit()
		to_global(tilemap.map_to_local(target_pos))


func _physics_process(delta):
	var is_close_to_curr_cell = adjus_to_cell + (tilemap.map_to_local(curr_pos + direction)) - global_position
	if (!is_moving && grid_diff == Vector2.ZERO):
		velocity = Vector2.ZERO
		direction = Vector2.ZERO
		is_moving = false
		return
		
	elif (is_moving && is_close_to_curr_cell.length() < 1):
		is_moving = false
		curr_pos = curr_pos + direction
		global_position = tilemap.map_to_local(curr_pos)
		set_next_cell_sign.emit()
		
	velocity = velocity.lerp(speed * direction, acceleration * delta)
	AudioPlayer.random_movement_sfx()
	move_and_slide()

func set_next_cell():
	direction = Vector2.ZERO
	if (grid_diff.y > 0):
		direction = Vector2(0, 1)
		grid_diff.y -= 1
	elif (grid_diff.y < 0):
		direction = Vector2(0, -1)
		grid_diff.y += 1
	elif (grid_diff.x > 0):
		direction = Vector2(1, 0)
		grid_diff.x -= 1
	elif (grid_diff.x < 0):
		direction = Vector2(-1, 0)
		grid_diff.x += 1
		
	if (direction != Vector2.ZERO):
		navig_agent.target_position = adjus_to_cell + to_global(tilemap.map_to_local(curr_pos + direction)) 
		is_moving = true
