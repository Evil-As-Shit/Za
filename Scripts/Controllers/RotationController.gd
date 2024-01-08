extends Node

class_name RotationController

static func _rotate(node:Node2D, rot:int):
	var has_rot_node:bool = false
	for child in node.get_children():
		if (child.name.begins_with("Rot_")): has_rot_node = true
	
	if (!has_rot_node):
		var rotNode:Node2D = Node2D.new()
		rotNode.name = "Rot_0"
		rotNode.y_sort_enabled = true
		node.add_child(rotNode)
		for child in node.get_children():
			if (rotNode == child): continue
			node.remove_child(child)
			rotNode.add_child(child)
	
	for child in node.get_children():
		if (child.name.begins_with("Rot_")): child.visible = false
		if (child.name == str("Rot_",rot)): child.visible = true
