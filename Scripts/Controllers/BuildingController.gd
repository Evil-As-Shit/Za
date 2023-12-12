extends Node2D

#@onready var table_small = preload("res://Scenes/Furniture/table_1x1.tscn")

var tile_map: TileMap
var preview_build: Node2D
var vector2i_null: Vector2i = Vector2i(-99999, -99999)

func _ready():
	tile_map = GameData.tile_map
	SignalController.build_start.connect(self._on_build)
	
#	set current item tiles
	for child in get_children():
		for subchild in child.get_children():
			if (subchild.name.begins_with("TileBlockable")):
				var clicked_cell = tile_map.local_to_map(subchild.global_position)
				var atlas_coords = tile_map.get_cell_atlas_coords(0, clicked_cell)
				tile_map.set_cell(0,clicked_cell,1,atlas_coords)
	

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

func _clear_preview():
	if (preview_build != null):
		preview_build.queue_free()
		preview_build = null

func _get_preview_tile_pos() -> Vector2i:
	var pos = vector2i_null
	var clicked_cell:Vector2i = tile_map.local_to_map(tile_map.get_local_mouse_position())
	var cell_id:int = tile_map.get_cell_source_id(0, clicked_cell)
	if (cell_id == 0): pos = tile_map.map_to_local(clicked_cell)
	return pos
