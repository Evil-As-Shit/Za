class_name Utility

static func is_at(pos1:Vector2, pos2:Vector2, margin:float = 1.0) -> bool:
	var diffVector = Vector2(pos2.x - pos1.x, pos2.y - pos1.y)
	var squaredDistance = diffVector[0]*diffVector[0] + diffVector[1]*diffVector[1]
	return squaredDistance < (margin * margin)

# debug: gets the methods and properties of a class
static func dir(class_instance):
	var output = {}
	var methods = []
	for method in class_instance.get_method_list():
		methods.append(method.name)
	
	output["METHODS"] = methods
	
	var properties = []
	for prop in class_instance.get_property_list():
		if prop.type == 3:
			properties.append(prop.name)
	output["PROPERTIES"] = properties

	return output
