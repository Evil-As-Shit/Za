extends Node2D


func _ready():
	SignalController.connect("load_game", self._on_load_game)
	
	GameData.game_mode = "action_walk"
	LoadSaveController.save_game()
	_on_load_game("savegame.save")

func _process(_delta):
	pass

func _on_load_game(save_file:String):
	GameData.tile_map.clear()
	GameData.item_nodes.clear()
	for node in get_node("BuildingController").get_children():
		node.queue_free()
	
	LoadSaveController.load_game(save_file)
