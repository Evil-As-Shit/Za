extends Node2D

#@onready var table_small = preload("res://Scenes/Furniture/table_1x1.tscn")

var tile_map: TileMap
var preview_build: Node2D
var vector2i_null: Vector2i = Vector2i(-99999, -99999)

func _ready():
	tile_map = GameData.tile_map
	SignalController.build_start.connect(self._on_build)
	SignalController.build_complete.connect(self._on_build_complete)
	SignalController.load_item.connect(self._on_load_item)
	
#	set current item tiles
	for child in get_children():
		var id:int = GameData._get_next_id()
		_set_tile_blockables(id, child)
		GameData.item_nodes[id] = child

func _process(_delta):
	if (GameData.game_mode != "action_build"):
		_clear_preview()
		return
	var pos = _get_preview_tile_pos()
	if (pos == vector2i_null): pos = get_local_mouse_position()
	preview_build.position = pos
#	print("Building!")

func _on_build(to_build:String):
	_clear_preview()
	var path = str("res://Scenes/Furniture/", to_build, ".tscn")
	preview_build = load(path).instantiate()
	add_child(preview_build)
	GameData.item_to_build = to_build

func _on_build_complete():
	if (preview_build == null): return
	var pos:Vector2i = _get_preview_tile_pos()
	if (pos == vector2i_null): return
	_set_tile_blockables(GameData._get_next_id(), preview_build)
	preview_build = null
	GameData.item_to_build = ""

func _set_tile_blockables(id:int, item:Node):
	for child in item.get_children():
		if (child.name.begins_with("TileBlockable")):
			var cell = tile_map.local_to_map(child.global_position)
			var atlas_coords = tile_map.get_cell_atlas_coords(0, cell)
			tile_map.set_cell(0, cell, 1, atlas_coords)
			GameData.tile_item[GameData._get_tile_id(cell)] = id

func _clear_preview():
	if (preview_build != null):
		preview_build.queue_free()
		preview_build = null
		GameData.item_to_build = ""

func _get_preview_tile_pos() -> Vector2i:
	var pos:Vector2i = vector2i_null
	var is_buildable:bool = true
	for child in preview_build.get_children():
		if (child.name.begins_with("TileBlockable")):
			var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position() + child.position)
			var cell_id:int = tile_map.get_cell_source_id(0, clicked_cell)
			if (cell_id == 0):
				if (pos == vector2i_null): pos = tile_map.map_to_local(clicked_cell)
			else:
				is_buildable = false
	if (is_buildable): return pos
	return vector2i_null

func _on_load_item(id:int, scene_file_name:String, pos_x:int, pos_y:int):
	var path = str("res://Scenes/Furniture/", scene_file_name, ".tscn")
	var item:Node2D = load(path).instantiate()
	item.position = Vector2(pos_x, pos_y)
	add_child(item)
	_set_tile_blockables(id, item)
	GameData.item_nodes[id] = item
