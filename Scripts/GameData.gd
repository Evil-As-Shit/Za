extends Node

#Autoloaded

class RecipeItem:
	var type:String = "" # the kind of food e.g. water, dough
	var get_date:int = 0 # the day it was obtained/created
	var quality:int = 0 # the quality of the food, ten being best, zero being trash
	func _init(_type, _get_date, _quality):
		type = _type
		get_date = _get_date
		quality = _quality

var tile_map: TileMap
var item_nodes:Dictionary = {} # id_Node2D
var item_rot:Dictionary = {} # id_int 0,1,2, or 3
var npc_nodes:Dictionary = {} # id_Node2D
var tile_item:Dictionary = {} # tileId_id
var tile_is_free:Dictionary = {} # tileID_bool
var worker_is_free:Dictionary = {} # id_bool
var worker_brain:Dictionary = {} # id_GoalSequence
var entity_inventorys:Dictionary = {} # id_Array[RecipeItem]
# remember to clear Dictionary in _reset()!

var game_mode: String = ""
var button_hovered: String = ""
var item_hovered: String = ""
var tile_hovered: String = ""
var item_to_build: String = ""
var save_dir: String = "save_files"

var player_money:int = 10
var next_id:int = 0

func _get_next_id() -> int:
	next_id += 1
	return next_id

func _get_tile_id(cell:Vector2i) -> String:
	return str(cell.x,"_",cell.y)

func _reset():
	for id in item_nodes: item_nodes[id].queue_free()
	for id in npc_nodes: npc_nodes[id].queue_free()
	tile_map.clear()
	item_nodes.clear()
	npc_nodes.clear()
	tile_item.clear()
	tile_is_free.clear()
	worker_is_free.clear()
