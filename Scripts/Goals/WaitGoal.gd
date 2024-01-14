class_name WaitGoal
extends Goal

var _time_left:float

func _init(t:float):
	_time_left = t

func _update(delta:float):
	_time_left -= delta
	is_finished = _time_left <= 0
