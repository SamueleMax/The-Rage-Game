extends KinematicBody2D

const const_speed = 200
const despawn_distance = 700

var speed = 0
var direction

var spawn_position

var velocity = Vector2(0, 0)

func throw_bullet(var requested_position, var requested_direction):
	spawn_position = requested_position
	position = requested_position
	direction = requested_direction
	if direction == 1:
		$Sprite.flip_h = true
	show()
	speed = const_speed
	
func _physics_process(delta):
	if is_on_wall():
		queue_free()
	
	# Check if too far away from trunk
	if direction == 1:
		if position.x > spawn_position.x + despawn_distance:
			queue_free()
	elif direction == -1:
		if position.x < spawn_position.x - despawn_distance:
			queue_free()
	
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_collision_checker_body_entered(body):
	body.hit()
