extends Node


@onready var default_timer_time: int = 601
var castle_count: int = 0
var control_squad_one = true
var current_player_power: int = 100
var timer: int = 601

signal castle_taken
signal castle_lost
signal player_win
signal player_lose
signal new_annoucement(num: int)
signal got_support(num: int)
signal angry_morale(num: int)
signal player_changed(num: int)
signal decrease_game_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	castle_taken.connect(update_castle_taken)
	castle_lost.connect(update_castle_lost)
	decrease_game_timer.connect(on_one_sec)


func _process(delta):
	pass


func update_castle_taken():
	castle_count += 1
	
	if castle_count >= 5:
		player_win.emit()


func update_castle_lost():
	castle_count -= 1
	angry_morale.emit(1)


func on_one_sec():
	timer -= 1
	if (timer > 0):
		await get_tree().create_timer(1).timeout
		decrease_game_timer.emit()
	else:
		player_lose.emit()
