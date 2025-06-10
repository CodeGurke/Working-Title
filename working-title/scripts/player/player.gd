extends CharacterBody2D

# This script is used inside the player scene and is used for things like:
# controls, building the body


# The following variables are:
# 1. Info, this is the resource that holds selected parts and the players' stats
# 2. Input Device, every controller is assigned a number inside the engine, this is used for input handling
# 3. Direction, this variable is used in calculating the players movement

@export var info : PlayerInfo
var input_device : int
var direction : float

var team: int
signal hit(damage:int)


# This function is automatically called once the project has loaded
# It first duplicates the info resource because resources are shared between nodes
# Then it calculates the stats from the parts
# After it calculates some stats by multiplying them because the lower values would be too slow
# Then it builds the body as explained later

func _ready() -> void:
	info = info.duplicate(true)
	info.calculate_stats()
	calculate_stats()
	build_body()
	team = input_device;


# The following function is run every physics tick
# It handles the players' movement and attack inputs

func _physics_process(delta) -> void:
	
	# This gets the Vector2 of the movement input according to the input device
	var input_dir := Input.get_vector("move_left_"+str(input_device), "move_right_"+str(input_device), "move_up_"+str(input_device), "move_down_"+str(input_device))
	
	# This handles jumping by checking if up is inputed and player is on floor
	if input_dir.y < 0 and is_on_floor():
		
		velocity.y = info.jump_force
	
	
	# handles acceleration and deceleration
	# The if else is used to differ the behavior based on if the player is in the air or not
	# Here lerp is used to add acceleration and deceleration to make movement smoother
	
	if is_on_floor():
		
		# handles movemnt on the floor
		direction = lerp(direction, input_dir.x, delta * info.acceleration)
		
	else:
		
		# This adds gravity to make the players fall
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * info.gravity_multiplier * delta
		
		
		# This is used to make the player slow down and speed up differently in the air
		
		if input_dir == Vector2.ZERO:
			
			# handles deceleration in the air
			direction = lerp(direction, 0.0, delta * info.acceleration/5)
			
		else:
			
			# handles acceleration in the air
			direction = lerp(direction, input_dir.x, delta * (info.acceleration/3))
			
	
	
	# This applies the actual movement of the player 
	
	if direction:
		
		# applies velocity in the inputed direction
		velocity.x = direction * info.speed
		
	else:
		
		# decelerates the player when not inputing any direction
		velocity.x = move_toward(velocity.x, 0, info.speed * delta)
		
	
	move_and_slide()
	
	##base attack code
	var handanim = $AnimationPlayer
	if Input.is_action_pressed("base_attack_"+str(input_device)) && handanim.current_animation == "idle":
		if input_dir == Vector2.DOWN:
			handanim.play("d_tilt")
		elif input_dir == Vector2.UP:
			handanim.play("u_tilt")
		elif input_dir == Vector2.LEFT or input_dir == Vector2.RIGHT:
			handanim.play("f_tilt")
		else:
			handanim.play("punch")
		
	if !handanim.is_playing():
		handanim.play('idle')


# This function is called inside _ready() 
# This dynamically builds the body by setting the texture of the predefined Sprite2D nodes
# It also offsets each sprite to connect them together
# ^ This assumes the sprites (apart from the head) go from the bottom to the top of the texture file
# 
# It also sets the players hurtbox dynamically, hit detection is not implemented currently :/

func build_body() -> void:
	$legs.texture = info.legs.sprite
	$legs.offset.y = -(float(info.legs.height) / 2)
	$body.texture = info.body.sprite
	$body.offset.y = -(info.legs.height + float(info.body.height) / 2)
	$head.texture = info.head.sprite
	$head.offset.y = -(info.legs.height + info.body.height + float(info.head.height) / 2)
	$lhand.texture = info.hand_l.sprite
	$lhand.offset.y = -(info.legs.height)
	$lhand.offset.x = +(float(info.legs.width)/2 + info.hand_l.width)
	$rhand.texture = info.hand_r.sprite
	$rhand.offset.y = -(info.legs.height)
	$rhand.offset.x = -(float(info.legs.width)/2 + info.hand_r.width)
	$lhand/Area2D.scale.x = (info.hand_l.width)
	$lhand/Area2D.scale.y = (info.hand_l.height)
	
	var hurtbox := CollisionShape2D.new()
	hurtbox.set_shape(CapsuleShape2D.new())
	hurtbox.position.y = -(float(info.legs.height + info.body.height + info.head.height) / 2)
	hurtbox.shape.set_height(float(info.legs.height + info.body.height + info.head.height))
	hurtbox.shape.set_radius(float(info.get_max_width()) / 2)
	add_child(hurtbox)


# This function multiplies some stats
# For the sake of simplicity i wanted the jump and speed to not be values like 500
# So instead here they are simply multiplied so the bodyparts can have simple values like 5

func calculate_stats() -> void:
	info.speed = info.speed * 100
	info.jump_force = info.jump_force * 100


func hitbox_entered_hurtbox(hitbox : Area2D,hurtbox : CollisionShape2D) -> void:
	hurtbox = self.hurtbox
	if(hitbox is HitBox && hitbox.team != team):
		hit.emit(hitbox.damage)
