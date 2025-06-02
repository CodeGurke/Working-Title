class_name Map
extends Node2D

# This script is used for maps but is quite outdated and should be updated


# This function is called from the game_controller script and is used to get the spawn locations for players
# Inside the maps' scene Marker2Ds can be set and named to set spawn points for players

func get_spawn_locations() -> Dictionary:
	
	var spawn_locations : Dictionary = {}
	var location_markers : = %spawn_locations.get_children()
	
	for entry in location_markers:
		
		spawn_locations.get_or_add(entry.name, entry.get_global_position())
	
	return spawn_locations


# This function emits a signal used by the game_controller script to handle what happens if a player
# leaves the playable are defined the the player_zone Area2D

func _on_player_zone_body_exited(body : CharacterBody2D):
	
	SignalManager.player_left_play_area.emit(body)
