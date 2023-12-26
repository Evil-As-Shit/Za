extends Node2D

func _ready():
	print("Viewport resolution is: ", get_viewport().get_visible_rect().size)
	pass

func _process(_delta):
	
	pass

func _input(event: InputEvent):
	if (event.is_action_pressed("click_left")):
		if (GameData.button_hovered != ""):
			if (GameData.button_hovered == "debug_walk"): GameData.game_mode = "action_walk"
			if (GameData.button_hovered.begins_with("build_")):
				GameData.game_mode = "action_build"
				SignalController.emit_signal("build_start", GameData.button_hovered.replace("build_", ""))
			if (GameData.button_hovered.begins_with("loadgame_")):
				SignalController.emit_signal("load_game", str(GameData.button_hovered.replace("loadgame_", ""), ".save"))
			if (GameData.button_hovered.begins_with("DebugLoadGameButton")):
				SignalController.emit_signal("toggle_load_menu")
		elif (GameData.game_mode == "action_walk"):
			SignalController.emit_signal("debug_walk_to", get_global_mouse_position())
		elif (GameData.game_mode == "action_build"):
			if (MoneyController._can_afford_build()):
				MoneyController._purchase_build()
				SignalController.emit_signal("build_complete")
				GameData.game_mode = "action_walk"
			else:
				print("You can't afford that!")
		else:
			print("InputController: I don't know what to do! ", GameData.button_hovered)
		
