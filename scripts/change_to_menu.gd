extends Node


@export var main_menu: PackedScene
@export var is_loop: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_loop:
		await get_tree().create_timer(5).timeout
		_on_change_scene()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_change_scene():
	AudioPlayer.change_scene(main_menu.resource_name)
	get_tree().change_scene_to_packed(main_menu)
