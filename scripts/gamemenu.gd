extends Control

@onready var menu_buttons: VBoxContainer = $MarginContainer/HBoxContainer/menu
@onready var settings: VBoxContainer = $MarginContainer/HBoxContainer/settings
@onready var about: VBoxContainer = $MarginContainer/HBoxContainer/about


@export var game_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.play_music("main_menu")
	for element in menu_buttons.get_children():
		if element is Button:
			element.pressed.connect(menu.bind(element.name))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func menu(menu_elem):
	match(menu_elem):
		"Start":
			AudioPlayer.change_scene("level_main")
			get_tree().change_scene_to_packed(game_scene)
			
			#SceneTransition.change_scene(game_scene)
		"Settings":
			menu_buttons.visible = false
			settings.visible = true
			about.visible = false
		"About":
			menu_buttons.visible = false
			settings.visible = false
			about.visible = true
		"Exit":
			get_tree().quit()



func _on_back_pressed() -> void:
	menu_buttons.visible = true
	settings.visible = false
	about.visible = false


func _on_music_vol_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), linear_to_db(value))


func _on_sfx_vol_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(value))
