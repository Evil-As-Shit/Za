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
	add(DebugPrintGoal.new(str(_owner_id, " is interacting with ", _item_id)))

func _update(delta:float):
	super._update(delta)
	
	if (is_finished):
		var node:Node2D = GameData.npc_nodes[_owner_id]
		var pos:Vector2 = node.position
		
		if (Utility.is_at(pos, _pos)):
			var inventory:Array = GameData.entity_inventorys[_owner_id]
			inventory.append(GameData.RecipeItem.new("output item", 0, 0))
			inventory.append(GameData.RecipeItem.new("output item 2", 0, 0))
			print("My name is ",_owner_id," and I'm holding ",GameData.entity_inventorys[_owner_id].size()," things")
			for inv in GameData.entity_inventorys[_owner_id]:
				var inv2:GameData.RecipeItem = inv
				print(" ",inv2.type)
