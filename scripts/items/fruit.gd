extends Area2D

func _on_body_entered(_body):
	# Disable player collision
	set_collision_mask_bit(1, false)
	
	# Add 1 to current fruits
	level_stats.current_fruits += 1
	
	$collected_sound.play()
	$AnimatedSprite.play("collected")
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()
