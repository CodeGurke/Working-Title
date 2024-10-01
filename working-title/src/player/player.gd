extends CharacterBody2D

var speed : int = 500



func _physics_process(delta):
	var movement : Vector2 = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	print(movement)
	
	velocity = movement * speed
	move_and_slide()
