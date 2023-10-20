extends KinematicBody2D

func _on_bottom_player_checker_body_entered(body):
	body.on_fan()

func _on_top_player_checker_body_entered(body):
	body.fan_reached_top()

func _on_bottom_player_checker_body_exited(body):
	# Wait time
	yield(get_tree().create_timer(0.075), "timeout")
	body.off_fan()
