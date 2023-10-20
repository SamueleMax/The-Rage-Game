extends Control

func _ready():
	if options.game_finished:
		$secret_settings_button.show()

func _on_back_button_pressed():
	get_tree().change_scene("res://menus/main_menu.tscn")

func _on_fullscreen_button_pressed():
	OS.window_fullscreen = not OS.window_fullscreen

func _on_pink_pressed():
	options.player = "pink"


func _on_blue_pressed():
	options.player = "blue"


func _on_mask_pressed():
	options.player = "mask"


func _on_frog_pressed():
	options.player = "frog"


func _on_secret_settings_button_pressed():
	get_tree().change_scene("res://menus/secret_settings.tscn")
