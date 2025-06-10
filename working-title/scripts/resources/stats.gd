class_name Stats
extends Resource

# This script is the base for all body parts and hods the stats assigned to every part
# This is also the base for the script that holds player stats
# Every value is defined as a export variable so it can be easily set inside the inspector of a resource

@export var speed : float
@export var jump_force : float
@export var gravity_multiplier : float
@export var acceleration : float
