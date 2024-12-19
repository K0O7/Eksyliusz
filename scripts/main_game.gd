extends Node2D


@export var end_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioPlayer.play_music("game")
	GameManager.player_win.connect(player_win)
	GameManager.player_lose.connect(player_lose)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func player_win():
	await get_tree().create_timer(1).timeout 
	AudioPlayer.change_scene(end_scene.resource_name)
	get_tree().change_scene_to_packed(end_scene)


func player_lose():
	await get_tree().create_timer(1).timeout 
	AudioPlayer.change_scene(end_scene.resource_name)
	get_tree().change_scene_to_packed(end_scene)
