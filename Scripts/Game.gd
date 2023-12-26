extends Node2D


func _ready():
	GameData.game_mode = "action_walk"
	LoadSaveController.save_game()
	
	GameData.tile_map.clear()
	
	
	LoadSaveController.load_game("savegame.save")

func _process(_delta):
	pass
