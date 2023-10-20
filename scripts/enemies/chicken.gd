extends KinematicBody2D

# Consts
const const_speed = 100
const const_gravity = 2.5
const const_jumpforce = -200

# Vars of consts in case it's needed to modify them
var speed = const_speed
var gravity = const_gravity
var jumpforce = const_jumpforce

# Vars
export var direction = 1

var idle = true
# If the ride has just ended, so when the player
# ends it it doesn't automatically restart
var ride_just_ended = false

# Chicken's vector
var velocity = Vector2(0, 0)

# Functions
# Change direction
func change_direction(var requested_direction):
	# Opposite direction
	if requested_direction == 0:
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	# Right direction
	elif requested_direction == 1:
		direction = 1
		$AnimatedSprite.flip_h = true
	# Left direction
	elif requested_direction == -1:
		direction = -1
		$AnimatedSprite.flip_h = false

func start_ride():
	if not ride_just_ended:
		# Disable collisions, so that the chicken can jump
		$player_checker.set_collision_mask_bit(1, false)
		
		player_info.riding = true
		$AnimatedSprite.play("walking")
		idle = false
		speed = const_speed
	else:
		ride_just_ended = false

func end_ride():
	ride_just_ended = true
	
	speed = 0
	idle = true
	player_info.riding = false
	$AnimatedSprite.play("idle")
	
	# Teleport player next to chicken
	player_info.player_node.position.x = position.x
	
	# Re-enable collisions
	$player_checker.set_collision_mask_bit(1, true)

func _on_player_checker_body_entered(_body):
	start_ride()

# Ready function
func _ready():
	speed = 0
	
	# Set direction
	if direction == 1:
		change_direction(1)
	elif direction == -1:
		change_direction(-1)

# Physics process
func _physics_process(_delta):
	if not idle:
		# Set player position and direction
		if direction == 1:
			player_info.player_node.get_node("AnimatedSprite").flip_h = false
			player_info.player_node.position.x = position.x - 5
		elif direction == -1:
			player_info.player_node.get_node("AnimatedSprite").flip_h = true
			player_info.player_node.position.x = position.x + 5
		
		player_info.player_node.position.y = position.y - 27.5
		
		# Check for key presses
		if Input.is_action_pressed("left"):
			change_direction(-1)
			velocity.x = -speed
		elif Input.is_action_pressed("right"):
			change_direction(1)
			velocity.x = speed
		
		# Jump
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = jumpforce
		
		# End ride
		if Input.is_action_pressed("ctrl") and is_on_floor():
			end_ride()
	
	# Move chicken
	velocity.x = speed * direction
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
