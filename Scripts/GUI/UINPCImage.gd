extends UINPC

func _update(id:int):
	if (not GameData.worker_stats.has(id)):
		visible = false
		return
	visible = true
	
	set_label("LabelName", GameData.get_worker_stat(id, "name"))
	set_label("LabelType", GameData.get_worker_stat(id, "type"))
	visible = true

func set_label(label:String, s:String):
	get_node("PanelBottom").get_node("HBoxContainer").get_node(label).text = s
