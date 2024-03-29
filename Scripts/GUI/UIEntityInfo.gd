extends Control

func _ready():
	SignalController.gui_update_entity.connect(self.on_update_entity)
	for child in get_children():
		if child is UINPC:
			child.visible = false
	
func on_update_entity(id:int):
	for child in get_children():
		if child is UINPC: child._update(id)
