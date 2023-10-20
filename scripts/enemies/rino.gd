extends KinematicBody2D

# Consts
const const_speed = 150
const const_gravity = 80

# Vars of consts in case it's needed to modify them
var speed = const_speed
var gravity = const_gravity

# Vars
export var direction = 1
export var detects_void = false

var idle = true
var lives = 2
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

func _on_side_checker_body_entered(body):
	if body.name == "bricks":
		body.destroy()
		change_direction(0)
	elif body == player_info.player_node:
		body.hit()

func _on_player_checker_body_entered(body):
	$idle_timer.stop()
	if idle:
		# Set direction to player's direction
		if player_info.player_node.position.x > position.x:
			change_direction(1)
		elif player_info.player_node.position.x < position.x:
			change_direction(-1)
	idle = false
	$AnimatedSprite.play("run")
	speed = const_speed

func _on_player_checker_body_exited(body):
	$idle_timer.start()

func _on_idle_timer_timeout():
	speed = 0
	$AnimatedSprite.play("idle")
	idle = true

# Ready function
func _ready():
	speed = 0
	
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
	if not idle:
		# Change direction
		if is_on_floor() and (is_on_wall() or ($edge_checker.enabled and not $edge_checker.is_colliding())):
			# Rino just got hit!
			if lives > 0 and not hit_cooldown:
				speed = 0
				hit_cooldown = true
				lives -= 1
				$AnimatedSprite.play("hit_wall")
				yield(get_tree().create_timer(0.8), "timeout")
				change_direction(0)
				speed = const_speed
				$AnimatedSprite.play("run")
				yield(get_tree().create_timer(1), "timeout")
				hit_cooldown = false
			elif lives <= 0 and not hit_cooldown:
				# Disable player collision
				$side_checker.set_collision_mask_bit(1, false)
				$AnimatedSprite.play("hit")
				yield(get_tree().create_timer(1), "timeout")
				level_stats.killed_enemies += 1
				queue_free()
			else:
				change_direction(0)
		
	# Move enemy
	velocity.x = speed * direction
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
