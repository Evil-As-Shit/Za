extends Camera2D

@export var key : bool = true
@export var camera_speed : int = 80
var __keys = [false, false, false, false]
var camera_movement = Vector2()
var Zoom_Speed = 2
var zoomPos = null

func _physics_process(delta):
	if key:
		if __keys[0]:
			camera_movement.x -= camera_speed * delta
		if __keys[1]:
			camera_movement.y -= camera_speed * delta
		if __keys[2]:
			camera_movement.x += camera_speed * delta
		if __keys[3]:
			camera_movement.y += camera_speed * delta
	position += camera_movement
	camera_movement = Vector2(0,0)

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom.x = zoom.x + 1
		zoom.y = zoom.y + 1
		zoom.x = clamp(zoom.x,2,6)
		zoom.y = clamp(zoom.y,2,6)
		print(get_zoom())
	if event.is_action_pressed("zoom_out"):
		zoom.x = zoom.x - 1
		zoom.y = zoom.y - 1
		zoom.x = clamp(zoom.x,2,6)
		zoom.y = clamp(zoom.y,2,6)
		print(get_zoom())
	if event.is_action_pressed("left"):
		__keys[0] = true
	if event.is_action_pressed("up"):
		__keys[1] = true
	if event.is_action_pressed("right"):
		__keys[2] = true
	if event.is_action_pressed("down"):
		__keys[3] = true
	if event.is_action_released("left"):
		__keys[0] = false
	if event.is_action_released("up"):
		__keys[1] = false
	if event.is_action_released("right"):
		__keys[2] = false
	if event.is_action_released("down"):
		__keys[3] = false
