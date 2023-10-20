extends KinematicBody2D

func _on_player_checker_body_entered(body):
	$AnimatedSprite.play("in_use")
	body.trampoline_jump()
	yield(get_tree().create_timer(0.8), "timeout")
	$AnimatedSprite.play("idle")
