extends Control

@onready var panel = $Panel
@onready var menu_buttons: VBoxContainer = $Panel/MarginContainer/HBoxContainer/menu
@onready var settings: VBoxContainer = $Panel/MarginContainer/HBoxContainer/settings
@onready var ig_ui = $IG_UI
@onready var morale: TextureRect = $IG_UI/Morale

var morale_seq = [
	0,
	2,
	1,
	3
]


var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.new_annoucement.connect(change_morale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if Input.is_action_just_pressed("Pause"):
		manage_pause()
		
func manage_pause():
	is_paused = !is_paused

	panel.visible = is_paused
	ig_ui.visible = !is_paused
	get_tree().paused = is_paused
	print("Paused ", is_paused)


func _on_resume_pressed():
	manage_pause()


func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	menu_buttons.visible = false
	settings.visible = true


func _on_back_pressed():
	menu_buttons.visible = true
	settings.visible = false


func change_morale():
	#for i in range(morale_seq.size()):
		#morale.set_frame_texture(morale_seq[i])
	pass
