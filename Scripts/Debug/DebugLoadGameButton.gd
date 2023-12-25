extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	SignalController.toggle_load_menu.connect(self._on_load_menu)
	
	var dir:DirAccess = DirAccess.open(str("user://",GameData.save_dir))
	if (dir):
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				print("Found file: ", file_name)
				var button:Button = Button.new()
				button.name = "loadgame_" + file_name.replace(".save", "")
				button.set_script(UIButton)
				button.text = file_name.replace(".save", "")
				add_child(button)
			file_name = dir.get_next()
			
func _on_load_menu():
	visible = !visible
