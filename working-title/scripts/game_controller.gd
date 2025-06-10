extends Node

# This script is used the handle centralized logic used to control the game
# This are things like spawning players and the map


# The following variables hold a path to the player and map scenes

const player_1 : = preload("res://scenes/player.tscn")
const player_2 : = preload("res://scenes/player.tscn")
var map : = preload("res://scenes/maps/test_map.tscn")


# The folowing variables are used to hold references to the instanced versions of players and map

var instanced_player_1 : CharacterBody2D
var instanced_player_2 : CharacterBody2D
var instanced_map : Node2D


# This function is automatically called once the project has loaded
# It connects to the signal that is used to check if any player has left the play area
# It also spawns the map

func _ready():
	
	SignalManager.player_left_play_area.connect(_on_player_left_play_area)
	spawn_map()


# This function instantiates the map, adds it to the world and then spawns players

func spawn_map() -> void:
	
	instanced_map = map.instantiate()
	%game.add_child.call_deferred(instanced_map)
	spawn_players(instanced_map.get_spawn_locations())


# This function instantiates players, spawns them on the map and sets their input device

func spawn_players(spawn_locations : Dictionary) -> void:
	
	instanced_player_1 = player_1.instantiate()
	instanced_player_2 = player_2.instantiate()
	
	instanced_player_1.input_device = 0
	instanced_player_2.input_device = 1
	
	%game.add_child.call_deferred(instanced_player_1)
	%game.add_child.call_deferred(instanced_player_2)
	
	instanced_player_1.global_position = spawn_locations["player_1"]
	instanced_player_2.global_position = spawn_locations["player_2"]


# This function is called when an player is detected leaving the playable area

func _on_player_left_play_area(player : CharacterBody2D) -> void:
	
	player.global_position = Vector2(0,0)
