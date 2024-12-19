extends Area2D

@export var tilemap: TileMapLayer
@export var is_enemy = true
@export var power_level = 10
@export var starting_pos: Vector2
var basic_power = 10
@export var fight_speed: float = 0.001
@onready var power: Label = $power
@onready var entity_spawner: Node2D = $entity_spawner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	power.text = str(power_level)
	global_position = tilemap.map_to_local(starting_pos)
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
			player.units_sprites()
			await get_tree().create_timer(fight_speed).timeout
		if self.power_level == 0:
			self.power_level = self.basic_power
			self.power.text = str(self.power_level)
			self.is_enemy = false
			GameManager.castle_taken.emit()
			entity_spawner.start = true
	else:
		while(player.power_level > 0 and self.power_level > 0):
			player.power_level -= 1
			self.power_level -= 1
			self.power.text = str(self.power_level)
			player.power.text = str(player.power_level)
			player.units_sprites()
			await get_tree().create_timer(fight_speed).timeout
		GameManager.player_lose.emit()
