extends Area2D

@export var tilemap: TileMapLayer
@export var is_enemy = true
@export var power_level = 10
@export var starting_pos: Vector2
@export var smoke: PackedScene
var basic_power = 10
@export var fight_speed: float = 0.001
@onready var power: Label = $power
@onready var entity_spawner: Node2D = $entity_spawner
@onready var robot_spawner = $RobotSpawner/entity_spawner

@onready var sprite2d = $Sprite2D
@onready var sprite_anim: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	power.text = str(power_level)
	global_position = tilemap.map_to_local(starting_pos)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func camp_is_attacked(player: CharacterBody2D):
	AudioPlayer.play_sfx("town_alarm", 4)
	var new_entity = smoke.instantiate()
	add_sibling(new_entity)
	new_entity.global_position = global_position
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
			self.sprite2d.visible = false
			$LightOccluder1.visible = false
			self.sprite_anim.visible = true
			$LightOccluder2D.visible = true
			self.sprite_anim.play("default")
			GameManager.castle_taken.emit()
			entity_spawner.start = true
			robot_spawner.start = true
			AudioPlayer.play_sfx("town_capture", 1)
		await get_tree().create_timer(1).timeout 
		new_entity.queue_free()
	else:
		while(player.power_level > 0 and self.power_level > 0):
			player.power_level -= 1
			self.power_level -= 1
			self.power.text = str(self.power_level)
			player.power.text = str(player.power_level)
			player.units_sprites()
			await get_tree().create_timer(fight_speed).timeout
		new_entity.queue_free()
		GameManager.player_lose.emit()
