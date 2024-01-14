class_name InteractionItemGoal
extends GoalSequence

var _owner_id:int
var _item_id:int

func _init(owner_id:int, item_id:int, pos:Vector2):
	_owner_id = owner_id
	_item_id = item_id
	
	add(WalkGoal.new(owner_id, pos))
	add(DebugPrintGoal.new(str(_owner_id, " is interacting with ", _item_id)))
