extends Node


@export var default_state : Node

var states : Array[Node] = get_children()
var active_states : Array[Node]



func _init():
	active_states.append(default_state)

func process_frame() -> void:
	pass

func process_physics() -> void:
	pass
