class_name WalkGoal
extends Goal

var _owner_id:int
var _destination:Vector2

func _init(owner_id:int, pos:Vector2):
	_owner_id = owner_id
	_destination = pos
	
	GameData.npc_nodes[owner_id]._on_debug_walk_to(pos)

func _update(_delta:float):
	var node:Node2D = GameData.npc_nodes[_owner_id]
	var pos:Vector2 = node.position
	
	is_finished = Utility.is_at(pos, _destination)
