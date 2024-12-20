extends CharacterBody2D


@export var SPEED = 20.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@export var smoke: PackedScene
@export var fight_speed: float = 0.001
@export var power_level = 10
@onready var power: Label = $power


func _physics_process(delta):
	var direction = 1
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func camp_is_attacked(player: CharacterBody2D):
	AudioPlayer.play_sfx("town_alarm", 4)
	var new_entity = smoke.instantiate()
	add_sibling(new_entity)
	new_entity.global_position = global_position
	if player.power_level > self.power_level:
		while(player.power_level > 0 and self.power_level > 0):
			self.SPEED = 0
			player.power_level -= 1
			self.power_level -= 1
			self.power.text = str(self.power_level)
			player.power.text = str(player.power_level)
			player.units_sprites()
			await get_tree().create_timer(fight_speed).timeout
		if self.power_level == 0:
			new_entity.queue_free()
			self.queue_free()
			#self.power_level = self.basic_power
			#self.power.text = str(self.power_level)
			#GameManager.castle_taken.emit()
			#AudioPlayer.play_sfx("town_capture", 1)
		#await get_tree().create_timer(1).timeout 
		#new_entity.queue_free()
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
