extends Node

#@onready var table_small = preload("res://Scenes/Furniture/table_1x1.tscn")

var tile_map: TileMap

func _ready():
	tile_map = GameData.tile_map
	SignalController.build.connect(self._on_build)
	
#	set current item tiles
	for child in get_children():
		for subchild in child.get_children():
			if (subchild.name.begins_with("TileBlockable")):
				var clicked_cell = tile_map.local_to_map(subchild.global_position)
				var atlas_coords = tile_map.get_cell_atlas_coords(0, clicked_cell)
				tile_map.set_cell(0,clicked_cell,1,atlas_coords)
	

func _process(_delta):
	if (GameData.game_mode != "action_build"): return
#	print("Building!")

func _on_build(to_build:String):
	print("Building ", to_build)
	
