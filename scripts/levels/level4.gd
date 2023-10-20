extends Node2D

# Vars
# If timer hasn't already been started
var timer_started = false

func _ready():
	# Set current level
	level_stats.current_level = 4
	
	# Disable riding
	player_info.riding = false
	# Disable fly
	options.fly_enabled = false
	# Disable immmortality
	options.immortal = false
	
	# Initialize current stats
	level_stats.current_fruits = 0
	level_stats.killed_enemies = 0
	level_stats.counting_time = false
	level_stats.passed_time = 0
	
	# Set total stats
	level_stats.total_fruits = 46
	level_stats.total_enemies = 13
	level_stats.total_time = 25

func _on_passed_time_timer_timeout():
	# Count time
	if level_stats.counting_time:
		level_stats.passed_time += 1
		$passed_time_timer.start()

func _process(_delta):
	# Restart level
	if Input.is_action_just_pressed("r"):
		# warning-ignore: return_value_discarded
		get_tree().reload_current_scene()
	
	# Start timer
	if not timer_started and level_stats.counting_time:
		timer_started = true
		$passed_time_timer.start()
