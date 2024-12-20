extends CharacterBody2D


@export var SPEED = 20.0
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta):
	var direction = 1
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
