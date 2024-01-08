extends Node

class_name InteractionController

var tile_map:TileMap

func _ready():
	tile_map = GameData.tile_map
	SignalController.interact_item.connect(self._on_interact_item)

func _on_interact_item(id:int):
	var item:Node2D = GameData.item_nodes[id]
	for child in ItemController._get_interactions(item):
		var cell:Vector2i = tile_map.local_to_map(child.global_position)
		var cell_id = GameData._get_tile_id(cell)
		if (GameData.tile_is_free[cell_id]):
			var worker_id = _get_nearest_worker(cell)
			if (worker_id != -1):
				GameData.tile_is_free[cell_id] = false
				GameData.worker_is_free[worker_id] = false
				GameData.npc_nodes[worker_id]._on_debug_walk_to(child.global_position)
				return

func _get_nearest_worker(coord:Vector2i) -> int:
	var closest_distance = INF
	for worker_id in GameData.npc_nodes:
		if (GameData.worker_is_free[worker_id]): return worker_id
	return -1
