extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var nav_agent : NavigationAgent2D = get_node("NavigationAgent2D")
@export var move_speed: float = 50.0
@export var move_acc: float = 50.0
enum STATE {IDLE,WALK}
var time = false
var move_direction = Vector2.ZERO
var current_state = STATE.IDLE : set = set_current_state

var tile_map:TileMap

var is_debug_print: bool = false

func _ready():
	tile_map = GameData.tile_map
	
	SignalController.debug_walk_to.connect(self._on_debug_walk_to)

func set_current_state(new_state):
	if(new_state == current_state):
		return
	match(new_state):
		STATE.IDLE:
			state_machine.travel("Idle")
		STATE.WALK:
			state_machine.travel("Walk")
	current_state = new_state

func _input(event):
#	if event.is_action_pressed("click_right"):
#		var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
#		var atlas_coords = tile_map.get_cell_atlas_coords(0, clicked_cell)
#		tile_map.set_cell(0,clicked_cell,1,atlas_coords)
#		if (is_debug_print) : print("cell changed")
	pass

func _physics_process(_delta:float)->void:
	if nav_agent.is_navigation_finished():
		current_state = STATE.IDLE
		return
	move_direction = to_local(nav_agent.get_next_path_position()).normalized()
	current_state = STATE.WALK
	update_animation_parameters(move_direction)
	var intended_velocity = move_direction * move_speed
	nav_agent.set_velocity(intended_velocity)

func update_animation_parameters(move_input : Vector2):
	animation_tree.set("parameters/Idle/blend_position",move_input)
	animation_tree.set("parameters/Walk/blend_position",move_input)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_debug_walk_to(pos:Vector2):
	nav_agent.target_position = pos
