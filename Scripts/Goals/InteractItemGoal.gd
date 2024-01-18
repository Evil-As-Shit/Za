class_name InteractionItemGoal
extends GoalSequence

var _owner_id:int
var _item_id:int
var _pos:Vector2

func _init(owner_id:int, item_id:int, pos:Vector2):
	_owner_id = owner_id
	_item_id = item_id
	_pos = pos
	
	add(WalkGoal.new(owner_id, pos))

func _update(delta:float):
	super._update(delta)
	
	if (is_finished):
		var node:Node2D = GameData.npc_nodes[_owner_id]
		var pos:Vector2 = node.position
		
		if (Utility.is_at(pos, _pos)):
			var inventory:Array = GameData.entity_inventorys[_owner_id]
			inventory.append(GameData.RecipeItem.new("cheese", 0, 0))
			inventory.append(GameData.RecipeItem.new("sauce", 0, 0))
