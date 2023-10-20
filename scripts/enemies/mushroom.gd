extends KinematicBody2D

# Consts
const const_speed = 100
const const_gravity = 80

# Vars of consts in case it's needed to modify them
var speed = const_speed
var gravity = const_gravity

# Vars
export var direction = 1
export var detects_void = true

var hit_cooldown = false

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
	body.trampoline_jump()
	
	if not hit_cooldown:
		$AnimatedSprite.play("hit")
		speed = 0
		hit_cooldown = true
		$hit_cooldown.start()
		yield(get_tree().create_timer(0.5), "timeout")
		$AnimatedSprite.play("idle")

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

func _on_hit_cooldown_timeout():
	hit_cooldown = false
	speed = const_speed
	$AnimatedSprite.play("walking")

# Physics process
func _physics_process(delta):
	# Change direction
	if is_on_floor() and (is_on_wall() or ($edge_checker.enabled and not $edge_checker.is_colliding())):
		change_direction(0)
	
	# Move enemy
	velocity.x = speed * direction
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
