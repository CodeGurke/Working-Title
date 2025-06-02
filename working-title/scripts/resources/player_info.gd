class_name PlayerInfo
extends Stats

# This script is made to be a ressource that holds the players' selected bodyparts and stats
# Every value is defined as a export variable so it can be easily set inside the inspector of a resource

@export var legs : Bodypart
@export var body : Bodypart
@export var head : Bodypart
@export var hand_l : Bodypart
@export var hand_r : Bodypart


# This function is used from the player script
# It adds the stats every bodypart has individually to set the players stats

func calculate_stats() -> void:
	speed = legs.speed + body.speed + head.speed
	jump_force = legs.jump_force + body.jump_force + head.jump_force
	gravity_multiplier = 1 + legs.gravity_multiplier + body.gravity_multiplier + head.gravity_multiplier
	acceleration = legs.acceleration + body.acceleration + head.acceleration


# This function is used from the player script
# Its function is to calculate the highest width value and is used to dynamically set the players' hurtbox

func get_max_width() -> int:
	var max_width : int = legs.width
	
	if max_width < body.width:
		max_width = body.width
	if max_width < head.width:
		max_width = head.width
	
	return max_width
