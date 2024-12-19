extends Node

var sfx = {
	#"door_open": preload("res://Audio/door_open.mp3"),
}

var timed_sfx = {
	#"steam_engine": preload("res://Audio/steam_engine_running.mp3"),
}

var movement_sfx = [
]

var music_sfx_names = {
	"game": preload("res://Cyberiada Audio FX/Music/main_theme.mp3"),
	"main_menu": preload("res://Cyberiada Audio FX/Music/main_menu.mp3")
}

var walking_sfx = [
	preload("res://Cyberiada Audio FX/SFX/Walk/walk-1.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Walk/walk-2.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Walk/walk-3.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Walk/walk-4.mp3")
]

var is_movement_running = false
var is_clicked_sound = false

#func _input(event):
	#if event is InputEventMouseButton && event.pressed && !is_clicked_sound:
		#is_clicked_sound = true
		#var asp = AudioStreamPlayer.new()
		#asp.stream = sfx["mouse_clicked"]
		#asp.name = "SFX"
		#asp = add_to_bus(asp, "clicked")
		#
		#add_child(asp)
		#asp.play()
		#
		#await asp.finished
		#asp.queue_free()
		#is_clicked_sound = false

func play_music(music_name: String):
	if music_sfx_names.has(music_name):
		var asp = AudioStreamPlayer.new()
		asp.stream = music_sfx_names[music_name]
		asp.name = "Music"
		asp = add_to_bus(asp, music_name)
		
		add_child(asp)
		asp.play()


func play_sfx(sfx_name: String):
	if sfx.has(sfx_name):
		var asp = AudioStreamPlayer.new()
		asp.stream = sfx[sfx_name]
		asp.name = "SFX"
		asp = add_to_bus(asp, sfx_name)
		
		add_child(asp)
		asp.play()
		
		await asp.finished
		asp.queue_free()


#func play_timed_sfx(sfx_name: String, signal_name):
	#if timed_sfx.has(sfx_name):
		#var asp = AudioStreamPlayer.new()
		#asp.stream = timed_sfx[sfx_name]
		#if sfx_name == "level_bg":
			#asp.name = "level_bg"
		#else:
			#asp.name = "Timed_SFX"
		#asp = add_to_bus(asp, sfx_name)
		#
		#add_child(asp)
		#asp.play()
		#
		#await signal_name
		#if asp != null:
			#asp.queue_free()

func random_movement_sfx():
	if is_movement_running:
		return
	
	is_movement_running = true
	var asp = AudioStreamPlayer.new()
	asp.stream = walking_sfx[randi() % walking_sfx.size()]
	asp.name = "Movement_SFX"
	asp = add_to_bus(asp)
	
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
	is_movement_running = false

#func player_dead():
	#for child in get_children():
		#if child == null:
			#continue
		#if child.name == "Movement_SFX" || child.name == "SFX":
			#await child.finished
		#remove_child(child)
		#child.queue_free()


func change_scene(scene_name="default"):
	var sfx_to_del = []
	for child in get_children():
		var is_menu = scene_name == "" && child.name == "main_menu"
		var is_game = scene_name == "" && child.name == "game"

		if is_menu || is_game:
			continue
			
		sfx_to_del.append(child)
		
	for child in sfx_to_del:
		if child == null:
			continue
		if child.name == "Movement_SFX" || child.name == "SFX":
			await child.finished
		remove_child(child)
		child.queue_free()


func add_to_bus(asp, sfx_name="default"):
	if sfx_name in music_sfx_names:
		asp.bus = "Music"
	else:
		asp.bus = "SFX"
	
	return asp
