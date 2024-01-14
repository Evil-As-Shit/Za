class_name GoalSequence
extends GoalComposite

func _update(delta:float):
	if (self.actions.size() > 0) :
		self.actions[0]._update(delta)
		if (self.actions[0].is_finished):
			self.actions.remove_at(0)
	is_finished = self.actions.size() == 0
