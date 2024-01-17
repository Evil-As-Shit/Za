extends Node


var is_building : bool = false

signal debug_walk_to
signal build_start
signal build_complete
signal build_rotate
signal toggle_load_menu
signal load_item(id:int, scene_file_name:String, pos_x:int, pos_y:int, rot:int)
signal load_npc(id:int, pos_x:int, pos_y:int, stats:String)
signal load_tile(layer:int, coords:Vector2i, source_id:int, atlas_coords:Vector2i, alternative_tile:int)
signal load_game(save_file:String)
signal interact_item(id:int)
signal hover_over(area:Area2D, b:bool)

signal gui_update_entity(id:int)
