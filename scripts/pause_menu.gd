extends Control

@onready var panel = $PauseMenu/Panel
@onready var menu_buttons: VBoxContainer = $PauseMenu/Panel/MarginContainer/HBoxContainer/menu
@onready var settings: VBoxContainer = $PauseMenu/Panel/MarginContainer/HBoxContainer/settings
@onready var ig_ui = $PauseMenu/IG_UI
@onready var morale: TextureRect = $PauseMenu/IG_UI/Morale
@onready var power = $PauseMenu/IG_UI/Power/Label
@onready var castle_state = $PauseMenu/IG_UI/Resources/Label
@onready var player_1 = $PauseMenu/IG_UI/Player1
@onready var player_2 = $PauseMenu/IG_UI/Player2
@onready var timer = $PauseMenu/IG_UI/Timer/Label


@onready var morale_seq = [
	load("res://Art/UI/morale_kolko.png"), #empty
	load("res://Art/UI/morale_zly.png"), # angry
	load("res://Art/UI/morale_neutralny.png"), # neutral
	load("res://Art/UI/morale_szczesliwy.png"),  # happy
	load("res://Art/UI/morale_smutny.png") #sad
]


var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.new_annoucement.connect(change_morale)
	GameManager.got_support.connect(change_morale)
	GameManager.angry_morale.connect(change_morale)
	GameManager.player_changed.connect(on_player_change)
	GameManager.new_annoucement.emit(4)


func _process(_delta):
	castle_state.text = str(GameManager.castle_count) + "/5"
	power.text = str(GameManager.current_player_power)
	timer.text = str(GameManager.timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_event):
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


func change_morale(num: int):
	print(num)
	morale.texture = morale_seq[num]


func on_player_change(num: int):
	if num == 1:
		player_1.material.set_shader_parameter("is_active", true)
		player_2.material.set_shader_parameter("is_active", false)
	elif num == 2:
		player_2.material.set_shader_parameter("is_active", true)
		player_1.material.set_shader_parameter("is_active", false)
