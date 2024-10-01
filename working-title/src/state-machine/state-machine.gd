extends Node


@export var default_state : Node

var states : Array[Node] = [$idle, $move, $jump, $fall]
var active_states : Array[Node]



func _init():
	active_states.append(default_state)

func process_frame() -> void:
	pass

func process_physics() -> void:
	active_states.clear()
	
	var movement : float = get_movement()
	var jump : bool = get_jump()
	
	if movement == 0 and jump == false:
		active_states.append($idle)
		return
	
	if movement != 0:
		active_states.append($move)
	
	if jump == true:
		active_states.append($jump)

func get_movement() -> float:
	return Input.get_axis('move_left', 'move_right')

func get_jump() -> bool:
	return Input.is_action_pressed("move_up")
