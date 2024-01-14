class_name DebugPrintGoal
extends Goal

var _to_print:String

func _init(s:String):
	_to_print = s

func _update(_delta):
	print(_to_print)
	is_finished = true
