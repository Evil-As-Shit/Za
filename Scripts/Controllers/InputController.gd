extends Node2D

var tile_map:TileMap

func _ready():
	tile_map = GameData.tile_map
	print("Viewport resolution is: ", get_viewport().get_visible_rect().size)
	SignalController.hover_over.connect(self.on_hover_over)

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
				GameData.button_hovered = ""
			if (GameData.button_hovered.begins_with("DebugLoadGameButton")):
				SignalController.emit_signal("toggle_load_menu")
		elif (GameData.game_mode == "action_build"):
			if (MoneyController._can_afford_build()):
				MoneyController._purchase_build()
				SignalController.emit_signal("build_complete")
				GameData.game_mode = "action_walk"
			else:
				print("You can't afford that!")
		else:
			SignalController.emit_signal("gui_update_entity",GameData.select_area_entitys[GameData.area_hovered])
	elif (event.is_action_pressed("click_right")):
		if (GameData.game_mode == "action_build"):
			SignalController.emit_signal("build_rotate")
		elif (GameData.game_mode == "action_walk"):
			var cell:Vector2i = tile_map.local_to_map(get_global_mouse_position())
			var tile_id:String = GameData._get_tile_id(cell)
			if (GameData.tile_item.has(tile_id)):
				SignalController.emit_signal("interact_item", GameData.tile_item[tile_id])
			else:
				SignalController.emit_signal("debug_walk_to", get_global_mouse_position())
	elif (event is InputEventMouseMotion):
		var pos = get_global_mouse_position()
		var cell:Vector2i = tile_map.local_to_map(pos)
		GameData.tile_hovered = str(cell.x, ", ", cell.y)
		GameData.item_hovered = ""
		if (GameData.tile_item.has(GameData._get_tile_id(cell))):
			GameData.item_hovered = str(GameData.tile_item[GameData._get_tile_id(cell)])
		
		var is_debug_print = false
		if (is_debug_print) : print("Mouse Motion at ", pos)
		if (is_debug_print) : print("cell location:",cell)

func on_hover_over(area:Area2D, b:bool):
	if (b):
		GameData.area_hovered = area
	elif (GameData.area_hovered == area):
		GameData.area_hovered = null
