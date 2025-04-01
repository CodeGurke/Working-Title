class_name Map
extends Node2D
# This is the Map class used for all maps


# this function dynamically gets the name and position of player spawn points that are children of the node spawn_locations
func get_spawn_locations() -> Dictionary:
	var spawn_locations : Dictionary = {}
	var location_markers : = %spawn_locations.get_children()
	
	for entry in location_markers:
		spawn_locations.get_or_add(entry.name, entry.get_global_position())
	return spawn_locations
