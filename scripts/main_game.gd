extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioPlayer.play_music("game")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass