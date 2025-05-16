class_name Character
extends Node2D

 
# holds the instances of the individual body parts to access later using code
var legs : CharacterBody2D
var body : CharacterBody2D
var head : CharacterBody2D
var hand_l : CharacterBody2D
var hand_r : CharacterBody2D

signal hit(damage:int)
var player : CharacterBody2D
var input_device : int
var handanim: AnimationPlayer

# holds the player characters stats
var speed : int = 500
var jump_force : int = -1000
var acceleration : float = 15.0
var direction : float

# TODO set this via the gamemanager
# hitboxes dont interact with hurtboxes of the same team affiliation
var team : int = 0


func _ready() -> void:
	player = self.get_parent()


# is processed every frame
func _process(delta):
	update_position()
	
	#base attack code
	handanim = hand_l.get_node("AnimationPlayer")
	if Input.is_action_pressed("base_attack_"+str(input_device)) && handanim.current_animation == "idle":
		if Input.is_action_pressed("move_left_"+str(input_device)) or Input.is_action_pressed("move_right_"+str(input_device)):
			handanim.play("f_tilt")
		elif Input.is_action_pressed("move_down_"+str(input_device)):
			handanim.play("d_tilt")
		elif Input.is_action_pressed("move_up_"+str(input_device)):
			handanim.play("u_tilt")
		else:
			handanim.play("punch")
		
	if !handanim.is_playing():
		handanim.play('idle')


# movement code
func _physics_process(delta) -> void:
	
	var input_dir := Input.get_vector("move_left_"+str(input_device), "move_right_"+str(input_device), "move_up_"+str(input_device), "move_down_"+str(input_device))
	
	# handles jumping
	if input_dir.y < 0 and player.is_on_floor():
		player.velocity.y = jump_force
	
	# handles acceleration and deceleration
	if player.is_on_floor():
		direction = lerp(direction, input_dir.x, delta * acceleration)
	else:
		# handles gravity & deceleration in the air
		player.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
		direction = lerp(direction, 0.0, delta * acceleration/5)
		
		if input_dir != Vector2.ZERO:
			# handles acceleration in the air
			direction = lerp(direction, input_dir.x, delta * (acceleration/3))
	
	if direction:
		# applies velocity in the inputed direction
		player.velocity.x = direction * speed
	else:
		# decelerates the player when not inputing any direction
		player.velocity.x = move_toward(player.velocity.x, 0, speed * delta)
	
	player.move_and_slide()


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
	#$legs/Area2D.area_entered.connect(hitbox_entered_hurtbox.bind($legs/Area2D))
	$body/Area2D.area_entered.connect(hitbox_entered_hurtbox.bind($body/Area2D))
	$head/Area2D.area_entered.connect(hitbox_entered_hurtbox.bind($head/Area2D))
	
	update_position()


func set_input_device(device : int) -> void:
	input_device = device
	team = device


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
	if(hitbox is HitBox && hitbox.team != team):
		hit.emit(hitbox.damage)
