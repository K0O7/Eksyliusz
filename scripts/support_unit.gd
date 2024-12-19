extends CharacterBody2D

@export var speed: int = 30
@export var acceleration: int = 100
@export var power_level: int = 20
@export var target: CharacterBody2D
@onready var power: Label = $power
@onready var navig_agent: NavigationAgent2D = $navig_agent

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	navig_agent.target_position = target.global_position
	power.text = str(power_level)

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	direction = navig_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction*speed, acceleration*delta)
	
	await get_tree().create_timer(0.5).timeout
	navig_agent.target_position = target.global_position
	
	move_and_slide()
	
func give_support():
	queue_free()
	pass
