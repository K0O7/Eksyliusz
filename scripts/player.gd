extends CharacterBody2D

class_name Player
@export var tilemap: TileMapLayer
@export var cell_size: int
@export var speed: int
@export var acceleration: int
@export var starting_pos: Vector2
@export var power_level: int
@onready var sprite_2d_3: AnimatedSprite2D = $Villager1
@onready var sprite_2d_2: AnimatedSprite2D = $Villager2
@export var animated_sprite_2d: AnimatedSprite2D
@export var is_active: bool = false


@onready var navig_agent: NavigationAgent2D = $NavigationAgent2D
@onready var power: Label = $power

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
	power.text = str(power_level)


func _input(event):
	if is_active:
		if Input.is_action_just_pressed("LMB_click"):
			target_pos = tilemap.local_to_map(get_global_mouse_position())
			curr_pos = tilemap.local_to_map(global_position)
			grid_diff = target_pos - curr_pos
			
			set_next_cell_sign.emit()
			to_global(tilemap.map_to_local(target_pos))

	if Input.is_action_just_pressed("control_squad_one"):
		is_active = false
		if name == "Player":
			is_active = true
	elif Input.is_action_just_pressed("control_squad_two"):
		is_active = false
		if name == "Player2":
			is_active = true


func _physics_process(delta):
	make_minions_sound()
	make_yippie_sound()
	var is_close_to_curr_cell = adjus_to_cell + (tilemap.map_to_local(curr_pos + direction)) - global_position
	#print(is_close_to_curr_cell)
	if (!is_moving && grid_diff == Vector2.ZERO):
		velocity = Vector2.ZERO
		direction = Vector2.ZERO
		animated_sprite_2d.play("Idle")
		sprite_2d_2.play("Idle")
		sprite_2d_3.play("Idle")
		is_moving = false
		return
		
	elif (is_moving && (is_close_to_curr_cell.x + is_close_to_curr_cell.y) < 50 && (is_close_to_curr_cell.x + is_close_to_curr_cell.y) > -50):
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
		animated_sprite_2d.play("WalkDown")
		sprite_2d_2.play("WalkDown")
		sprite_2d_3.play("WalkDown")
		grid_diff.y -= 1
	elif (grid_diff.y < 0):
		direction = Vector2(0, -1)
		animated_sprite_2d.play("WalkUp")
		sprite_2d_2.play("WalkUp")
		sprite_2d_3.play("WalkUp")
		grid_diff.y += 1
	elif (grid_diff.x > 0):
		direction = Vector2(1, 0)
		animated_sprite_2d.play("WalkSides")
		sprite_2d_2.play("WalkRight")
		sprite_2d_3.play("WalkRight")
		animated_sprite_2d.flip_h = true
		grid_diff.x -= 1
	elif (grid_diff.x < 0):
		direction = Vector2(-1, 0)
		animated_sprite_2d.play("WalkSides")
		sprite_2d_2.play("WalkLeft")
		sprite_2d_3.play("WalkLeft")
		animated_sprite_2d.flip_h = false
		grid_diff.x += 1
		
	if (direction != Vector2.ZERO):
		navig_agent.target_position = adjus_to_cell + to_global(tilemap.map_to_local(curr_pos + direction)) 
		is_moving = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attackable") and area.is_enemy:
		grid_diff = Vector2.ZERO
		area.camp_is_attacked(self)
		print("stepped")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group("support"):
		print("supp")
		power_level += body.power_level
		power.text = str(power_level)
		units_sprites()
		body.give_support()
	if body.is_in_group("attackable"):
		grid_diff = Vector2.ZERO
		body.robot_is_attacked(self)
		print("stepped")

func units_sprites():
	sprite_2d_3.visible = false
	sprite_2d_2.visible = false
		
		
	if self.power_level >= 200:
		sprite_2d_2.visible = true
	
	if self.power_level >= 300:
		sprite_2d_3.visible = true
		sprite_2d_2.visible = true
	

func make_minions_sound():
	var count = 1
	
	if (sprite_2d_2.visible):
		count += 1
		
	if (sprite_2d_3.visible):
		count += 1
		
	AudioPlayer.random_minion_sfx(count)


func make_yippie_sound():
	var count = 1
	
	if (sprite_2d_2.visible):
		count += 1
		
	if (sprite_2d_3.visible):
		count += 1
	
	await get_tree().create_timer(2).timeout
	AudioPlayer.random_yippie_sfx(count)
