extends Node2D

func _ready():
	print("Viewport resolution is: ", get_viewport().get_visible_rect().size)
	pass

func _process(_delta):
	
	pass

func _input(event: InputEvent):
	if (event.is_action_pressed("click_left")):
		if (GameData.button_hovered != ""):
			print("a button was pressed! ", GameData.button_hovered)
			if (GameData.button_hovered == "debug_walk"): GameData.game_mode = "action_walk"
			if (GameData.button_hovered.begins_with("build_")):
				GameData.game_mode = "action_build"
		elif (GameData.game_mode == "action_walk"):
			SignalController.emit_signal("debug_walk_to", get_global_mouse_position())
		elif (GameData.game_mode == "action_build"):
			print("building!")
		else:
			print("i don't know what to do! ")
		
