extends Node

class_name LoadSaveController

static func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var tile_map_dict = {}
	
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
				"atlas_coord_y": atlas_coords.y
			}
			tile_array.append(tile_dict)
		layer_dict[i] = tile_array
	tile_map_dict["tile_layers"] = layer_dict
	
	save_file.store_line(JSON.stringify(tile_map_dict))

static func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("Could not find save file")
		return
	
	GameData.tile_map.clear()
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
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
				GameData.tile_map.set_cell(int(layer_index), Vector2i(tile_dict["pos_x"], tile_dict["pos_y"]), tile_dict["source_id"], Vector2i(tile_dict["atlas_coord_x"], tile_dict["atlas_coord_y"]), 0)
