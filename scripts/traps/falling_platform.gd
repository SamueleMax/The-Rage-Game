extends KinematicBody2D

var off = false
var default_position

func _ready():
	default_position = position

func _on_player_checker_body_entered(body):
	$AnimatedSprite.play("off")
	$fall_timer.start()

func _on_fall_timer_timeout():
	off = true

func _physics_process(delta):
	if off:
		# Fall down
		position.y = lerp(position.y, 1100, 0.01)
		# Reset platform
		if position.y >= 1000:
			off = false
			$AnimatedSprite.play("on")
			position.y = default_position.y
