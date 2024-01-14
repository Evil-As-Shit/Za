class_name GoalComposite
extends Goal

var actions:Array = []

func add(goal:Goal):
	actions.append(goal)
