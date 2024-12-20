extends Node2D


@export var win_scene: PackedScene
@export var lose_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	#AudioPlayer.play_music("game")
	GameManager.player_win.connect(player_win)
	GameManager.player_lose.connect(player_lose)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func player_win():
	await get_tree().create_timer(1).timeout 
	AudioPlayer.change_scene(win_scene.resource_name)
	get_tree().change_scene_to_packed(win_scene)


func player_lose():
	await get_tree().create_timer(1).timeout 
	AudioPlayer.change_scene(lose_scene.resource_name)
	get_tree().change_scene_to_packed(lose_scene)
