extends Node2D

@onready var timer: Timer = $Timer

@export var time_to_spawn: float = 5.
@export var spawn_location_offset_X: int = 0
@export var spawn_location_offset_Y: int = 0
@export var entity_to_spawn: PackedScene
var start: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = time_to_spawn
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if start:
		AudioPlayer.random_spawn_sfx()
		var new_entity = entity_to_spawn.instantiate()
		add_sibling(new_entity)
		new_entity.global_position = global_position
