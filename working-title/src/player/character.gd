class_name Character
extends Node2D

 
# holds the instances of the individual body parts to access later using code
var legs : CharacterBody2D
var body : CharacterBody2D
var head : CharacterBody2D
var hand_l : CharacterBody2D
var hand_r : CharacterBody2D


# is processed every frame
func _process(delta):
	update_position()


# this function is called by the player script to build the players character
func build_body() -> void:
	# selected parts are stored in player and accessed here
	var parts : Array[PackedScene] = get_parent().get_selected_parts()
	
	# instantiates every part of the players body
	legs = parts[0].instantiate()
	body = parts[1].instantiate()
	head = parts[2].instantiate()
	hand_l = parts[3].instantiate()
	hand_r = parts[4].instantiate()
	
	# build the character body from the legs up
	%character.add_child(legs)
	%character.add_child(body)
	%character.add_child(head)
	%character.add_child(hand_l)
	%character.add_child(hand_r)
	
	# connects the hurtboxes of the individual body parts to a function
	$legs/Area2D.area_entered.connect(hitbox_entered_hurtbox.bind($legs/Area2D))
	$body/Area2D.area_entered.connect(hitbox_entered_hurtbox.bind($body/Area2D))
	$head/Area2D.area_entered.connect(hitbox_entered_hurtbox.bind($head/Area2D))
	
	update_position()


# this is used to change the rest of the body to movement of the piece the layer down
func update_position() -> void:
	body.global_position = legs.get_connector_position()
	head.global_position = body.get_connector_position()
	hand_l.global_position = legs.get_connector_position()
	hand_l.global_position.x += 30
	hand_r.global_position = legs.get_connector_position()
	hand_r.global_position.x -= 50


# function to check the hitbox that entered a hurtbox / ! unclear if hurtbox is assigned
func hitbox_entered_hurtbox(hitbox : Area2D, hurtbox : Area2D) -> void:
	pass
