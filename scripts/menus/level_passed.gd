extends Control

const last_level = 10

func _ready():
	if level_stats.current_level == last_level:
		$back_button.hide()
	
	# Hide next level button
	$next_level_button.hide()
	
	# Initialize in case there are no fruits or enemies
	$fruit_label.text = "0 / 0"
	$enemies_label.text = "0 / 0"
	$time_label.text = "0 / 0"
	
	# i is used to make an animation when counting the next values
	var i = 0
	
	# Wait 1 second
	yield(get_tree().create_timer(1), "timeout")
	
	# Animate fruits
	while i < level_stats.current_fruits:
		i += 1
		$fruit_label.text = str(i) + " / " + str(level_stats.total_fruits)
		yield(get_tree().create_timer(0.05), "timeout")
	# Check if the player has collected all the fruits
	if level_stats.current_fruits == level_stats.total_fruits:
		$fruit_label.text += " +1"
	i = 0
	yield(get_tree().create_timer(0.5), "timeout")
	
	# Animate enemies
	while i < level_stats.killed_enemies:
		i += 1
		$enemies_label.text = str(i) + " / " + str(level_stats.total_enemies)
		yield(get_tree().create_timer(0.05), "timeout")
	# Check if the player has killed all the enemies
	if level_stats.killed_enemies == level_stats.total_enemies:
		$enemies_label.text += " +1"
	i = 0
	yield(get_tree().create_timer(0.5), "timeout")
	
	# Animate time
	while i < level_stats.passed_time:
		i += 1
		$time_label.text = str(i) + " / " + str(level_stats.total_time)
		yield(get_tree().create_timer(0.05), "timeout")
	# Check if the player has completed the level in time
	if level_stats.passed_time <= level_stats.total_time:
		$time_label.text += " +1"
	i = 0
	yield(get_tree().create_timer(0.5), "timeout")
	
	
	# Show next level button
	$next_level_button.show()

func _on_next_level_button_pressed():
	if level_stats.current_level == last_level:
		get_tree().change_scene("res://menus/game_completed.tscn")
	else:
		get_tree().change_scene("res://levels/level" + str(level_stats.current_level + 1) + ".tscn")

func _on_back_button_pressed():
	get_tree().change_scene("res://menus/main_menu.tscn")
