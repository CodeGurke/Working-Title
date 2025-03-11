extends Node


const player_1 : = preload("res://src/player/player.tscn")
const player_2 : = preload("res://src/player/player.tscn")
var map : = preload("res://src/maps/test_map.tscn")

var instanced_player_1 : CharacterBody2D
var instanced_player_2 : CharacterBody2D
var instanced_map : Node2D


func _ready():
	spawn_map()

func spawn_map() -> void:
	instanced_map = map.instantiate()
	%game.add_child.call_deferred(instanced_map)
	spawn_players(instanced_map.get_spawn_locations())

func spawn_players(spawn_locations : Dictionary) -> void:
	instanced_player_1 = player_1.instantiate()
	instanced_player_2 = player_2.instantiate()
	
	instanced_player_1.set_input_device(0)
	instanced_player_2.set_input_device(1)
	
	%game.add_child.call_deferred(instanced_player_1)
	%game.add_child.call_deferred(instanced_player_2)
	
	instanced_player_1.global_position = spawn_locations["player_1"]
	instanced_player_2.global_position = spawn_locations["player_2"]
