extends Node

#Autoloaded

var tile_map: TileMap
var item_nodes:Dictionary = {}
var npc_nodes:Dictionary = {}

var game_mode: String = ""
var button_hovered: String = ""
var tile_hovered: String = ""
var item_to_build: String = ""
var save_dir: String = "save_files"

var player_money:int = 10
var next_id:int = 0

func _get_next_id() -> int:
	next_id += 1
	return next_id
