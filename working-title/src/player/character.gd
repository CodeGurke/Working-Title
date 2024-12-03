class_name Character
extends Node2D


# gets access to the part that is being used
# TODO make the parts selectable and change here automatically
const SELECTED_LEGS : = preload("res://src/player/parts/legs/legs_standart.tscn")
const SELECTED_BODY : = preload("res://src/player/parts/body/body.tscn")
const SELECTED_HEAD : = preload("res://src/player/parts/head/head.tscn")
const SELECTED_HAND_L : = preload("res://src/player/parts/hands/hand.tscn")
const SELECTED_HAND_R : = preload("res://src/player/parts/hands/hand.tscn")
 
# saves the instant of the part for later use like calling functions
var legs : CharacterBody2D = SELECTED_LEGS.instantiate()
var body : CharacterBody2D = SELECTED_BODY.instantiate()
var head : CharacterBody2D = SELECTED_HEAD.instantiate()
var hand_l : CharacterBody2D = SELECTED_HAND_L.instantiate()
var hand_r : CharacterBody2D = SELECTED_HAND_R.instantiate()


# call at start to build the players character
func build_body() -> void:
	# build the character body from the legs up
	%character.add_child(legs)
	%character.add_child(body)
	%character.add_child(head)
	%character.add_child(hand_l)
	%character.add_child(hand_r)
	
	update_position()


func update_position() -> void:
	body.global_position = legs.get_connector_position()
	head.global_position = body.get_connector_position()
	hand_l.global_position = legs.get_connector_position()
	hand_l.global_position.x += 30
	hand_r.global_position = legs.get_connector_position()
	hand_r.global_position.x -= 50


func _process(delta):
	update_position()
