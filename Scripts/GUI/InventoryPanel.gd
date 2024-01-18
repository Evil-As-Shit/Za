class_name InventoryPanel
extends Panel

func _ready():
	update(randi() % 4,1)

func update(x:float, y:float):
	var size:float = 64.0
	#$TextureRect.texture_normal_region = Rect2(x * size, y * size, size, size)
	#$TextureRect.region_rect = Rect2(x * size, y * size, size, size)
	$Sprite2D.region_rect = Rect2(x * size, y * size, size, size)
