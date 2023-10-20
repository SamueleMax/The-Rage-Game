extends Control


func _ready():
	options.game_finished = true
	# Create save file
	var game_finished_file = File.new()
	game_finished_file.open("game_finished", File.WRITE)
	game_finished_file.store_string("")
	game_finished_file.close()


func _on_menu_button_pressed():
	get_tree().change_scene("res://menus/main_menu.tscn")
