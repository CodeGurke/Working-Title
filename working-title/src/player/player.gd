extends CharacterBody2D


# gets access to the part that is being used
# TODO make the parts selectable and change here automatically
var selected_parts : Array[PackedScene]

# when everything is loaded builds the players character
func _ready() -> void:
	test_auto()
	%character.build_body()
	

func select_parts(legs : PackedScene, body : PackedScene, head : PackedScene, hand_l : PackedScene, hand_r : PackedScene) -> void:
	selected_parts = [legs, body, head, hand_l, hand_r]


func get_selected_parts() -> Array[PackedScene]:
	return selected_parts


# this function is for testing purposeses because a character builder is not built yet
func test_auto() -> void:
	select_parts(preload("res://src/player/parts/legs/legs_test.tscn"), preload("res://src/player/parts/body/body.tscn"), preload("res://src/player/parts/head/head.tscn"), preload("res://src/player/parts/hands/hand.tscn"), preload("res://src/player/parts/hands/hand.tscn"))
