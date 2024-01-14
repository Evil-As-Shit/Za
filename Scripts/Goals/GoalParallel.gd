class_name GoalParallel
extends GoalComposite

var _finished_actions:Array = []

func _update(delta:float):
	for _action in self.actions:
		_action._update(delta)
		if (_action.is_finished): _finished_actions.append(_action)
	for _action in _finished_actions:
		self.actions.erase(_action)
	_finished_actions.clear()
	is_finished = self.actions.size() == 0

