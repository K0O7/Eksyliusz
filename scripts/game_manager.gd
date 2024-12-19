extends Node

var castle_count: int = 0

signal castle_taken
signal player_win
signal player_lose

# Called when the node enters the scene tree for the first time.
func _ready():
	castle_taken.connect(update_castle_taken)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(castle_count)
	pass


func update_castle_taken():
	castle_count += 1
	
	if castle_count >= 5:
		player_win.emit()
