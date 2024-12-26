extends Node2D


#@export var win_scene: PackedScene
#@export var lose_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioPlayer.play_music("game")
	GameManager.player_win.connect(player_win)
	GameManager.player_lose.connect(player_lose)
	GameManager.timer = GameManager.default_timer_time
	GameManager.decrease_game_timer.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#"res://game_win.tscn"

func player_win():
	await get_tree().create_timer(1).timeout 
	AudioPlayer.change_scene("game_win")
	get_tree().change_scene_to_file("res://scenes/game_win.tscn")


func player_lose():
	await get_tree().create_timer(1).timeout 
	AudioPlayer.change_scene("game_over")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
