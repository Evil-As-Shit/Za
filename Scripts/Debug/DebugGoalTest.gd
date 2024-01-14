extends Node2D

var _goal_manager:GoalParallel

func _ready():
	_goal_manager = GoalParallel.new()
	
	var goal_group1:GoalSequence = GoalSequence.new()
	goal_group1.add(DebugPrintGoal.new("Starting 1"))
	goal_group1.add(WaitGoal.new(1.0))
	goal_group1.add(DebugPrintGoal.new("Ending 1"))
	_goal_manager.add(goal_group1)
	
	var goal_group2:GoalSequence = GoalSequence.new()
	goal_group2.add(DebugPrintGoal.new("Starting 2"))
	goal_group2.add(WaitGoal.new(2.0))
	goal_group2.add(DebugPrintGoal.new("Ending 2"))
	_goal_manager.add(goal_group2)
	
func _process(delta):
	_goal_manager._update(delta)
