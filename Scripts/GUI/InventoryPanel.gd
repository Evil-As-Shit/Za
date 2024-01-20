class_name InventoryPanel
extends Panel

func _ready():
	update(randi() % 4,1)

func update(x:float, y:float):
	var texture_size:float = 64.0
	$Sprite2D.region_rect = Rect2(x * texture_size, y * texture_size, texture_size, texture_size)
