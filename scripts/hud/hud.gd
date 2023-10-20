extends CanvasLayer

var g_pressed = false
var esc_pressed = false
var cheats_enabled = false

func _on_esc_timer_timeout():
	esc_pressed = false
	$esc_label.hide()

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		if g_pressed:
			g_pressed = false
			$goto_level.hide()
			$goto_level.text = ""
		elif not esc_pressed:
			$esc_label.show()
			esc_pressed = true
			$esc_timer.start()
		elif esc_pressed:
			get_tree().change_scene("res://menus/main_menu.tscn")
	if Input.is_action_just_pressed("g") and options.cheats_enabled:
		g_pressed = true
		$goto_level.show()
		$goto_level.grab_focus()
	
	if not cheats_enabled and (options.fly_enabled or options.immortal):
		cheats_enabled = true
		$fly_label.show()
		$immortal_label.show()
	if cheats_enabled:
		if options.fly_enabled:
			$fly_label.text = "Fly:   ON"
		else:
			$fly_label.text = "Fly:   OFF"
		if options.immortal:
			$immortal_label.text = "Immortal:   ON"
		else:
			$immortal_label.text = "Immortal:   OFF"
	
	$fruit_label.text = str(level_stats.current_fruits) + " / " + str(level_stats.total_fruits)
	$enemies_label.text = str(level_stats.killed_enemies) + " / " + str(level_stats.total_enemies)
	$time_label.text = str(level_stats.passed_time) + " / " + str(level_stats.total_time)

func _on_goto_level_text_entered(new_text):
	get_tree().change_scene("res://levels/level" + $goto_level.text + ".tscn")
