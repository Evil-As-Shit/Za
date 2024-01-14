class_name Utility

static func is_at(pos1:Vector2, pos2:Vector2, range:int = 1.0) -> bool:
	var diffVector = Vector2(pos2.x - pos1.x, pos2.y - pos1.y)
	var squaredDistance = diffVector[0]*diffVector[0] + diffVector[1]*diffVector[1]
	return squaredDistance < (range * range)
