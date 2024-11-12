class_name Character
extends Node2D


# gets access to the part that is being used
# TODO make the parts selectable and change here automatically
const SELECTED_LEGS : = preload("res://src/player/parts/legs/legs_standart.tscn")
const SELECTED_BODY : = preload("res://src/player/parts/body/body.tscn")
const SELECTED_HEAD : = preload("res://src/player/parts/head/head.tscn")
 
# saves the instant of the part for later use
var legs : CharacterBody2D = SELECTED_LEGS.instantiate()
var body : CharacterBody2D = SELECTED_BODY.instantiate()
var head : CharacterBody2D = SELECTED_HEAD.instantiate()


# call at start to build the players character
func build_body() -> void:
	# build the character body from the legs up
	%character.add_child(legs)
	%character.add_child(body)
	%character.add_child(head)
	
	# sets the pieces position to the connector of the last part
	body.global_position = legs.get_connector_position()
	head.global_position = body.get_connector_position()
