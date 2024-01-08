extends Node

class_name ItemController

static func _get_blockables(item:Node) -> Array:
	return _get_nodes_begin_with(item, "TileBlockable")

static func _get_interactions(item:Node) -> Array:
	return _get_nodes_begin_with(item, "TileInteraction")

static func _get_rot(item:Node) -> int:
	for child in item.get_children():
		if (child.name.begins_with("Rot_") && child.visible == true):
			return int(child.name.replace("Rot_", ""))
	return 0

static func _get_nodes_begin_with(item:Node, name:String) -> Array:
	var blockables:Array = []
	for child in item.get_children():
		if (child.name.begins_with("Rot_") && child.visible == true):
			for subchild in child.get_children():
				if (subchild.name.begins_with(name)):
					blockables.append(subchild)
	return blockables
