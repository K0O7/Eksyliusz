extends Node

var castle_count: int = 0
var control_squad_one = true

signal castle_taken
signal player_win
signal player_lose

# Called when the node enters the scene tree for the first time.
func _ready():
	castle_taken.connect(update_castle_taken)
	player_lose.connect(player_lose_ending)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_castle_taken():
	castle_count += 1
	
	if castle_count >= 5:
		player_win.emit()
		

func player_lose_ending():
	pass
