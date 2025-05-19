extends Node

const player_1 : = preload("res://scenes/player.tscn")
const player_2 : = preload("res://scenes/player.tscn")
var map : = preload("res://scenes/test_map.tscn")

var instanced_player_1 : CharacterBody2D
var instanced_player_2 : CharacterBody2D
var instanced_map : Node2D

func _ready():
	SignalManager.player_left_play_area.connect(_on_player_left_play_area)
	spawn_map()

func spawn_map() -> void:
	instanced_map = map.instantiate()
	%game.add_child.call_deferred(instanced_map)
	spawn_players(instanced_map.get_spawn_locations())

func spawn_players(spawn_locations : Dictionary) -> void:
	instanced_player_1 = player_1.instantiate()
	instanced_player_2 = player_2.instantiate()
	
	var player_1_input = instanced_player_1.get_node("character")
	var player_2_input = instanced_player_2.get_node("character")
	
	instanced_player_1.input_device = 0
	instanced_player_2.input_device = 1
	
	%game.add_child.call_deferred(instanced_player_1)
	%game.add_child.call_deferred(instanced_player_2)
	
	instanced_player_1.global_position = spawn_locations["player_1"]
	instanced_player_2.global_position = spawn_locations["player_2"]

func _on_player_left_play_area(player : CharacterBody2D) -> void:
	player.global_position = Vector2(0,0)
