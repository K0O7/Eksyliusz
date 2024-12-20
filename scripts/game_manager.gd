extends Node

var castle_count: int = 0
var control_squad_one = true

signal castle_taken
signal castle_lost
signal player_win
signal player_lose

# Called when the node enters the scene tree for the first time.
func _ready():
	castle_taken.connect(update_castle_taken)
	castle_lost.connect(update_castle_lost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(castle_count)
	pass


func update_castle_taken():
	castle_count += 1
	
	if castle_count >= 5:
		player_win.emit()
		
func update_castle_lost():
	castle_count -= 1
