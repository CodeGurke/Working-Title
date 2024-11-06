extends CharacterBody2D


# holds the player characters stats
# TODO should probably be moved to the character Node
var speed : int = 500
var jump_force : int = -2000
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")


# when everything is loaded builds the players character
func _ready() -> void:
	%character.build_body()


# movement code
func _physics_process(delta):
	var movement : int = Input.get_axis('move_left', 'move_right')
	var jump : bool = Input.is_action_pressed("move_up")
	
	velocity.x = movement * speed
	if jump == true and self.is_on_floor(): velocity.y = jump_force
	velocity.y += gravity
	
	move_and_slide()
