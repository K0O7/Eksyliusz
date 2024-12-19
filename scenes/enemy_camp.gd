extends Area2D

@export var is_enemy = true
@export var power_level = 10
@onready var power: Label = $power

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	power.text = str(power_level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func camp_is_attacked(player: CharacterBody2D):
	if player.power_level > self.power_level:
		while(player.power_level > 0 and self.power_level > 0):
			player.power_level -= 1
			self.power_level -= 1
			self.power.text = str(self.power_level)
			player.power.text = str(player.power_level)
			await get_tree().create_timer(0.001).timeout
		queue_free()
	pass
