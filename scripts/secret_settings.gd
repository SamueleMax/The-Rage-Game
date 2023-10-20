extends Control

func _ready():
	if options.cheats_enabled:
		$cheats_button.text = "Disable   cheats"
	else:
		$cheats_button.text = "Enable   cheats"

func _on_cheats_button_pressed():
	options.cheats_enabled = !options.cheats_enabled
	_ready()


func _on_back_button_pressed():
	get_tree().change_scene("res://menus/settings_menu.tscn")
