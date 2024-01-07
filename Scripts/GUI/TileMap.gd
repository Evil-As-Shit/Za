extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.tile_map = self
	
	SignalController.load_tile.connect(self._on_load_tile)

func _on_load_tile(layer:int, coords:Vector2i, source_id:int, atlas_coords:Vector2i, alternative_tile:int):
	set_cell(layer, coords, source_id, atlas_coords, alternative_tile)
	GameData.tile_is_free[GameData._get_tile_id(coords)] = true
