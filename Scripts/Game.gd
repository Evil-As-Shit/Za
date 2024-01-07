extends Node2D


func _ready():
	SignalController.connect("load_game", self._on_load_game)
	
	GameData.game_mode = "action_walk"
	LoadSaveController.save_game("savegame.save")
	LoadSaveController.load_game("savegame.save")

func _process(_delta):
	pass

func _on_load_game(save_file:String):
	for id in GameData.item_nodes: GameData.item_nodes[id].queue_free()
	for id in GameData.npc_nodes: GameData.npc_nodes[id].queue_free()
	GameData._reset()
	
	LoadSaveController.load_game(save_file)
