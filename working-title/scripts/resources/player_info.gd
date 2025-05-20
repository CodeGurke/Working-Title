class_name PlayerInfo
extends Stats

@export var legs : Bodypart
@export var body : Bodypart
@export var head : Bodypart
@export var hand_l : Bodypart
@export var hand_r : Bodypart

func calculate_stats() -> void:
	speed = legs.speed + body.speed + head.speed
	jump_force = legs.jump_force + body.jump_force + head.jump_force
	gravity_multiplier = 1 + legs.gravity_multiplier + body.gravity_multiplier + head.gravity_multiplier
	acceleration = legs.acceleration + body.acceleration + head.acceleration

func get_max_width() -> int:
	var max_width : int = legs.width
	
	if max_width < body.width:
		max_width = body.width
	if max_width < head.width:
		max_width = head.width
	
	return max_width
