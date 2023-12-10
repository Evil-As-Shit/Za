extends Node2D

@onready var tile_map = get_node("../TileMap")

var is_debug_print: bool = false

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if(tile_map.get_cell_source_id(0,tile_map.local_to_map(tile_map.get_local_mouse_position())) != -1):
		$Sprite2D.show()
		position = tile_map.map_to_local(tile_map.local_to_map(tile_map.get_local_mouse_position()))
	else:
		$Sprite2D.hide()
	if (is_debug_print) : print(tile_map.get_cell_source_id(0,tile_map.local_to_map(tile_map.get_local_mouse_position())))
