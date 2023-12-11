extends Node

@onready var table_small = preload("res://Scenes/Furniture/table_1x_1.tscn")



func _ready():
	SignalController.build.connect(self._on_build)
	

func _process(_delta):
	if (GameData.game_mode != "action_build"): return
#	print("Building!")

func _on_build(to_build:String):
	print("Building ", to_build)
	
