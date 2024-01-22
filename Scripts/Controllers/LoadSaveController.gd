extends Node

class_name LoadSaveController

static func save_game(file_name:String):
	var dir:DirAccess = DirAccess.open("user://")
	if (!dir.dir_exists(GameData.save_dir)):
		dir.make_dir(GameData.save_dir)
		
	var save_file = FileAccess.open(str("user://",GameData.save_dir,"/",file_name), FileAccess.WRITE)
	
	var save_file_dict = {}
	
	# tiles
	var layer_dict:Dictionary = {}
	for i in range(GameData.tile_map.get_layers_count()):
		var tile_array:Array = []
		for tile_pos in GameData.tile_map.get_used_cells(i):
			var x = tile_pos.x;
			var y = tile_pos.y;
			var source_id = GameData.tile_map.get_cell_source_id(i, Vector2i(x, y), false)
			var atlas_coords = GameData.tile_map.get_cell_atlas_coords(i, Vector2i(x, y), false)
			var tile_dict = {
				"pos_x": x,
				"pos_y": y,
				"source_id": source_id,
				"atlas_coord_x": atlas_coords.x,
				"atlas_coord_y": atlas_coords.y,
			}
			tile_array.append(tile_dict)
		layer_dict[i] = tile_array
	save_file_dict["tile_layers"] = layer_dict
	
	# recipe items
	var recipe_item_array:Array = []
	for key in GameData.entity_inventorys:
		for item in GameData.entity_inventorys[key]:
			var recipe_item:GameData.RecipeItem = item
			var item_dict = {
				"type": recipe_item.type,
				"get_date": recipe_item.get_date,
				"quality": recipe_item.quality,
			}
	
	# items
	var item_array:Array = []
	for key in GameData.item_nodes:
		var item:Node2D = GameData.item_nodes[key]
		var item_dict = {
			"id": key,
			"pos_x": item.position.x,
			"pos_y": item.position.y,
			"rot": ItemController._get_rot(item),
			"scene_file_name": item.scene_file_path.split('/')[-1].replace(".tscn",""),
		}
		item_array.append(item_dict)
		if (key > GameData.next_id): GameData.next_id = key
	save_file_dict["items"] = item_array
	
	# NPCs
	var npc_array:Array = []
	for key in GameData.npc_nodes:
		var npc:Worker = GameData.npc_nodes[key]
		var stat:String = npc.stats
		if (GameData.worker_stats.has(key)): stat = GameData.worker_stats[key]
		var npc_dict = {
			"id": key,
			"pos_x": npc.position.x,
			"pos_y": npc.position.y,
			"stats": stat,
		}
		npc_array.append(npc_dict)
		if (key > GameData.next_id): GameData.next_id = key
	save_file_dict["npcs"] = npc_array
	
	save_file.store_line(JSON.stringify(save_file_dict))

static func get_inventory_save(id:int) -> String:
	var s:String = ""
	var recipe_item_array:Array = []
	for key in GameData.entity_inventorys:
		for item in GameData.entity_inventorys[key]:
			var recipe_item:GameData.RecipeItem = item
			var item_dict = {
				"type": recipe_item.type,
				"get_date": recipe_item.get_date,
				"quality": recipe_item.quality,
			}
	return s

static func load_game(save_file_name:String):
	if not FileAccess.file_exists(str("user://",GameData.save_dir,"/",save_file_name)):
		print("Could not find save file: ", save_file_name)
		return
	
	var save_file = FileAccess.open(str("user://",GameData.save_dir,"/",save_file_name), FileAccess.READ)
	while (save_file.get_position() < save_file.get_length()):
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var node_data = json.get_data()
		for layer_index in node_data["tile_layers"]:
			for tile_dict in node_data["tile_layers"][layer_index]:
				SignalController.emit_signal("load_tile",
					int(layer_index),
					Vector2i(tile_dict["pos_x"], tile_dict["pos_y"]),
					tile_dict["source_id"],
					Vector2i(tile_dict["atlas_coord_x"],
					tile_dict["atlas_coord_y"]),
					0)
		for item_dict in node_data["items"]:
			SignalController.emit_signal("load_item",
				int(item_dict["id"]),
				item_dict["scene_file_name"],
				int(item_dict["pos_x"]),
				int(item_dict["pos_y"]),
				int(item_dict["rot"])
			)
		for npc_dict in node_data["npcs"]:
			SignalController.emit_signal("load_npc",
				int(npc_dict["id"]),
				int(npc_dict["pos_x"]),
				int(npc_dict["pos_y"]),
				npc_dict["stats"],
			)
