extends Node


#@export var main_menu: PackedScene
@export var is_loop: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_loop:
		await get_tree().create_timer(5).timeout
		_on_change_scene()


func _on_change_scene():
	AudioPlayer.change_scene("game_menu")
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
