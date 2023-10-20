extends Area2D

func _on_end_body_entered(body):
	# Stop time count
	level_stats.counting_time = false
	
	# Play animations
	$AnimatedSprite.play("reached")
	yield(get_tree().create_timer(0.8), "timeout")
	
	get_tree().change_scene("res://menus/level_passed.tscn")
