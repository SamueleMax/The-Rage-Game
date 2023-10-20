extends KinematicBody2D

# Consts
const const_speed = 500
const const_gravity = 80
const const_jumpforce = -975

# Vars of consts in case it's needed to modify them
var speed = const_speed
var gravity = const_gravity
var jumpforce = const_jumpforce

# Player's 2d vector
var velocity = Vector2(0, 0)

# Functions
func die():
	if not options.immortal:
		get_tree().reload_current_scene()

func hit():
	die()

func bounce():
	velocity.y = jumpforce

func trampoline_jump():
	velocity.y = jumpforce * 1.6

func on_fan():
	velocity.y = lerp(velocity.y, 0, 0.1)
	gravity = -10

func fan_reached_top():
	velocity.y = 0
	gravity = 0

func off_fan():
	gravity = const_gravity

func _ready():
	# Load sprite
	if options.player == "pink":
		$AnimatedSprite.frames = preload("res://players/animations/pink.tres")
	elif options.player == "frog":
		$AnimatedSprite.frames = preload("res://players/animations/frog.tres")
	elif options.player == "mask":
		$AnimatedSprite.frames = preload("res://players/animations/mask.tres")
	elif options.player == "blue":
		$AnimatedSprite.frames = preload("res://players/animations/blue.tres")
	
	player_info.player_node = self

# Physics process
func _physics_process(_delta):
	if Input.is_action_just_released("i") and options.cheats_enabled:
			options.immortal = !options.immortal
	
	# If player has fallen in void
	if position.y > 800:
		if not options.immortal:
			die()
		else:
			options.fly_enabled = true
			position.y = 300
	
	# If the player is not riding
	if not player_info.riding:
		# Enable or disable fly
		if Input.is_action_just_released("f") and options.cheats_enabled:
			options.fly_enabled = !options.fly_enabled
		
		# Check for key presses
		if Input.is_action_pressed("left"):
			velocity.x = -speed
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("walk")
		elif Input.is_action_pressed("right"):
			velocity.x = speed
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
		
		# Fly or jump
		if options.fly_enabled:
			speed = const_speed * 2
			
			if Input.is_action_pressed("up"):
				velocity.y = -speed
			elif Input.is_action_pressed("down"):
				velocity.y = speed
			
			velocity.y = lerp(velocity.y, 0, 0.5)
		else:
			speed = const_speed
			
			if Input.is_action_just_pressed("up") and is_on_floor():
				velocity.y = jumpforce
			
			velocity.y += gravity
	
	# If is in air
	if not is_on_floor():
		$AnimatedSprite.play("jump")
	
	# Move player
	velocity.x = lerp(velocity.x, 0, 0.5)
	velocity = move_and_slide(velocity, Vector2.UP)
