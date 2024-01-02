extends Node2D

func _ready():
	SignalController.load_npc.connect(self._on_load_npc)
	
	# set current npc tiles
	for child in get_children():
		GameData.npc_nodes[GameData._get_next_id()] = child

func _on_load_npc(id:int, pos_x:int, pos_y:int):
	var path = str("res://Scenes/worker.tscn")
	var npc:Node2D = load(path).instantiate()
	npc.position = Vector2(pos_x, pos_y)
	add_child(npc)
	GameData.npc_nodes[id] = npc
