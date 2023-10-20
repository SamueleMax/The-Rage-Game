extends KinematicBody2D

# Consts
const const_speed = 50
const const_gravity = 80

# Vars of consts in case it's needed to modify them
var speed = const_speed
var gravity = const_gravity

# Vars
export var direction = 1
export var detects_void = false

# Enemy's vector
var velocity = Vector2(0, 0)

# Functions
# Change direction
func change_direction(var requested_direction):
	# Opposite direction
	if requested_direction == 0:
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$edge_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	# Right direction
	elif requested_direction == 1:
		direction = 1
		$AnimatedSprite.flip_h = true
		$edge_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	# Left direction
	elif requested_direction == -1:
		direction = -1
		$AnimatedSprite.flip_h = false
		$edge_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _on_top_checker_body_entered(body):
	# Disable player collision
	$top_checker.queue_free()
	$side_checker.queue_free()
	set_collision_mask_bit(1, false)
	
	# Add 1 to killed enemies
	level_stats.killed_enemies += 1
	
	body.bounce()
	$AnimatedSprite.play("hit")
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()

func _on_side_checker_body_entered(body):
	body.hit()

# Ready function
func _ready():
	# Set direction
	if direction == 1:
		change_direction(1)
	elif direction == -1:
		change_direction(-1)
	
	# Set void detection
	if detects_void:
		$edge_checker.enabled = true

# Physics process
func _physics_process(delta):
	# Change direction
	if is_on_floor() and (is_on_wall() or ($edge_checker.enabled and not $edge_checker.is_colliding())):
		change_direction(0)
	
	# Move enemy
	velocity.x = speed * direction
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
