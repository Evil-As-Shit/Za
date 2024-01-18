extends UINPC

func _update(id:int):
	if (not GameData.entity_inventorys.has(id)):
		visible = false
		return
	visible = true
	for i in $GridContainer.get_child_count():
		var inventory = $GridContainer.get_child(i)
		if (not inventory is InventoryPanel): continue
		inventory.visible = false
		if (i >= GameData.entity_inventorys[id].size()): continue
		var inventory_name:String = GameData.entity_inventorys[id][i].type
		if (not RecipeController.Data.has(inventory_name)):
			print("UINPCInventory: No known recipe: ",inventory_name)
			continue
		var x = RecipeController.Data[inventory_name][1]
		var y = RecipeController.Data[inventory_name][2]
		inventory.update(x,y)
		inventory.visible = true
