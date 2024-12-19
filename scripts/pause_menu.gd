extends Control

@onready var panel = $Panel
@onready var menu_buttons: VBoxContainer = $Panel/MarginContainer/HBoxContainer/menu
@onready var settings: VBoxContainer = $Panel/MarginContainer/HBoxContainer/settings

var is_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if Input.is_action_just_pressed("Pause"):
		manage_pause()
		
func manage_pause():
	is_paused = !is_paused

	panel.visible = is_paused
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
