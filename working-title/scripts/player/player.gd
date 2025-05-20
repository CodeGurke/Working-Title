extends CharacterBody2D


@export var info : PlayerInfo
var input_device : int
var direction : float

# gets access to the part that is being used
# TODO make the parts selectable and change here automatically
var selected_parts : Array[PackedScene]

# when everything is loaded builds the players character
func _ready() -> void:
	info = info.duplicate(true)
	info.calculate_stats()
	calculate_stats()
	build_body()

func _physics_process(delta) -> void:
	
	var input_dir := Input.get_vector("move_left_"+str(input_device), "move_right_"+str(input_device), "move_up_"+str(input_device), "move_down_"+str(input_device))
	
	# handles jumping
	if input_dir.y < 0 and is_on_floor():
		velocity.y = info.jump_force
	
	# handles acceleration and deceleration
	if is_on_floor():
		direction = lerp(direction, input_dir.x, delta * info.acceleration)
	else:
		# handles gravity & deceleration in the air
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * info.gravity_multiplier * delta
		
		if input_dir == Vector2.ZERO:
			# handles deceleration in the air
			direction = lerp(direction, 0.0, delta * info.acceleration/5)
		else:
			# handles acceleration in the air
			direction = lerp(direction, input_dir.x, delta * (info.acceleration/3))
	
	if direction:
		# applies velocity in the inputed direction
		velocity.x = direction * info.speed
	else:
		# decelerates the player when not inputing any direction
		velocity.x = move_toward(velocity.x, 0, info.speed * delta)
	
	move_and_slide()
	
	##base attack code
	#handanim = hand_l.get_node("AnimationPlayer")
	#if Input.is_action_pressed("base_attack_"+str(input_device)) && handanim.current_animation == "idle":
		#if input_dir == Vector2.DOWN:
			#handanim.play("d_tilt")
		#elif input_dir == Vector2.UP:
			#handanim.play("u_tilt")
		#elif input_dir == Vector2.LEFT or input_dir == Vector2.RIGHT:
			#handanim.play("f_tilt")
		#else:
			#handanim.play("punch")
		#
	#if !handanim.is_playing():
		#handanim.play('idle')

func build_body() -> void:
	$legs.texture = info.legs.sprite
	$body.texture = info.body.sprite
	$head.texture = info.head.sprite

func calculate_stats() -> void:
	info.speed = info.speed * 100
	info.jump_force = info.jump_force * 100

func select_parts(legs : PackedScene, body : PackedScene, head : PackedScene, hand_l : PackedScene, hand_r : PackedScene) -> void:
	selected_parts = [legs, body, head, hand_l, hand_r]


func get_selected_parts() -> Array[PackedScene]:
	return selected_parts


# this function is for testing purposeses because a character builder is not built yet
func test_auto() -> void:
	select_parts(preload("res://scenes/legs/legs_test.tscn"), preload("res://scenes/bodies/body.tscn"), preload("res://scenes/heads/head.tscn"), preload("res://scenes/hands/hand.tscn"), preload("res://scenes/hands/hand.tscn"))
