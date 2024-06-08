extends CharacterBody2D

const WALK_FORCE = 600
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 390
var secondJump = false
var jumpFromWall = false
var facingRight = true

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (Input.get_axis(&"move_left", &"move_right"))
		
	if Input.is_action_pressed("move_left"):
		facingRight = false
		animation_player.play("walk")
	elif Input.is_action_pressed("move_right"):
		facingRight = true
		animation_player.play("walk")
	else:
		animation_player.play("iddle")
	
	if facingRight:
		sprite_2d.scale.x = 0.2
	else:
		sprite_2d.scale.x = -0.2
	
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta

	# Move based on the velocity and snap to the ground.
	# TODO: This information should be set to the CharacterBody properties instead of arguments: snap, Vector2.DOWN, Vector2.UP
	# TODO: Rename velocity to linear_velocity in the rest of the script.
	move_and_slide()
	
	if is_on_floor():
		secondJump = false
	
	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed(&"jump"):
		velocity.y = -JUMP_SPEED
	
	if  !is_on_floor() and Input.is_action_just_pressed(&"jump") and !secondJump:
		velocity.y = -JUMP_SPEED
		secondJump = true
		
	if  !is_on_wall():
		jumpFromWall = false
	
	if  is_on_wall() and Input.is_action_just_pressed(&"jump") and !jumpFromWall:
		velocity.y = -JUMP_SPEED
		jumpFromWall = true
