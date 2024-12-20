extends Node

var sfx = {
	"town_alarm": preload("res://Cyberiada Audio FX/SFX/Town/town-alarm.mp3"),
	"town_capture": preload("res://Cyberiada Audio FX/SFX/Town/town-capture.mp3")
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
	preload("res://Cyberiada Audio FX/SFX/Walk/walk-3.mp3")
]

var minion_sfx = [
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-1.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-2.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-3.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-4.mp3")
]

var town_spawn_sfx = [
	preload("res://Cyberiada Audio FX/SFX/Town/town-spawn-1.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Town/town-spawn-2.mp3")
]

var minion_yippie_sfx = [
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-yippie-1.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-yippie-2.mp3"),
	preload("res://Cyberiada Audio FX/SFX/Minion/minion-yippie-3.mp3")
]

var is_movement_running = false
var is_clicked_sound = false
var is_minion_talking = false
var is_yippie_talking = false

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


func play_sfx(sfx_name: String, pitch_scale: float = 1):
	if sfx.has(sfx_name):
		var asp = AudioStreamPlayer.new()
		asp.stream = sfx[sfx_name]
		asp.name = "SFX"
		asp.pitch_scale = pitch_scale
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
	asp = add_to_bus(asp, "sfx")
	
	add_child(asp)
	asp.play()
	
	await asp.finished
	await get_tree().create_timer(0.1).timeout 
	asp.queue_free()
	is_movement_running = false
	

func random_minion_sfx(counter: int):
	if is_minion_talking:
		return
	
	is_minion_talking = true
	var minion_sfx_list = []
	for i in range(counter):
		var asp = AudioStreamPlayer.new()
		asp.stream = minion_sfx[randi() % minion_sfx.size()]
		asp.name = "Minion_SFX"
		asp = add_to_bus(asp, "sfx")
		minion_sfx_list.append(asp)
	
		add_child(asp)
		asp.play()
	
	for i in range(minion_sfx_list.size()):
		await minion_sfx_list[i].finished
		minion_sfx_list[i].queue_free()
		
	await get_tree().create_timer(6).timeout
		
	is_minion_talking = false
	

func random_yippie_sfx(counter: int):
	if is_yippie_talking:
		return
	
	is_yippie_talking = true
	var minion_sfx_list = []
	for i in range(counter):
		var asp = AudioStreamPlayer.new()
		asp.stream = minion_yippie_sfx[randi() % minion_yippie_sfx.size()]
		asp.name = "Minion_SFX"
		asp = add_to_bus(asp, "sfx")
		minion_sfx_list.append(asp)
	
		add_child(asp)
		asp.play()
	
	for i in range(minion_sfx_list.size()):
		await minion_sfx_list[i].finished
		minion_sfx_list[i].queue_free()
		
	await get_tree().create_timer(15).timeout
		
	is_yippie_talking = false
	
	
func random_spawn_sfx():
	var asp = AudioStreamPlayer.new()
	asp.stream = town_spawn_sfx[randi() % town_spawn_sfx.size()]
	asp.pitch_scale = 8
	asp.name = "Spawn_SFX"
	asp = add_to_bus(asp, "sfx")
	
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()


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
