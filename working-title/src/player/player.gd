extends CharacterBody2D


# holds the player characters stats
# TODO the next 3 lines should probably be moved to the character Node
var speed : int = 500
var jump_force : int = -2000
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")

var input_device : int

# gets access to the part that is being used
# TODO make the parts selectable and change here automatically
var selected_parts : Array[PackedScene]

# when everything is loaded builds the players character
func _ready() -> void:
	test_auto()
	%character.build_body()


# movement code
func _physics_process(delta) -> void:
	velocity.y += gravity
	
	move_and_slide()

func _unhandled_input(event) -> void:
	if event.device == input_device:
		if event.is_action("move_left") or event.is_action("move_right"):
			velocity.x = Input.get_axis('move_left', 'move_right') * speed
		if event.is_action("move_up") and self.is_on_floor():
			velocity.y = jump_force
	

func select_parts(legs : PackedScene, body : PackedScene, head : PackedScene, hand_l : PackedScene, hand_r : PackedScene) -> void:
	selected_parts = [legs, body, head, hand_l, hand_r]


func get_selected_parts() -> Array[PackedScene]:
	return selected_parts

func set_input_device(device : int) -> void:
	input_device = device;

# this function is for testing purposeses because a character builder is not built yet
func test_auto() -> void:
	select_parts(preload("res://src/player/parts/legs/legs_test.tscn"), preload("res://src/player/parts/body/body.tscn"), preload("res://src/player/parts/head/head.tscn"), preload("res://src/player/parts/hands/hand.tscn"), preload("res://src/player/parts/hands/hand.tscn"))
