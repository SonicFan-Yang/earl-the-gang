extends Node2D
class_name Game_Master

var gamemaster : Node2D = self

var current_scene : Node2D
var error_scene = preload("res://scenes/levels/misc./error.tscn").instantiate()

var ysort_node = Node2D.new()
var old_ysort_node : Node2D

var player = preload("res://scenes/main/player.tscn").instantiate()
var camera := Camera2D.new()

func _ready() -> void:
	gamemaster = self

func _process(_delta: float) -> void:
	if get_child_count() > 0:
		if get_child(0) is Node2D:
			current_scene = get_child(0)
			#print(current_scene)
	else:
		current_scene = error_scene

func set_scene(new_scene : String, delete_room : bool = true, keep_player : bool = true):
	if current_scene != null:
		
		if keep_player == false:
			pass
		
		var sceneloaded := load(new_scene)
		var sceneinitialised : Node2D = sceneloaded.instantiate()
		var prev_scene_name := ""
		
		GlobalVariable.SCENE_LOADED = true
		#print(sceneinitialised)
		
		if current_scene != error_scene:
			current_scene = get_child(0)
			prev_scene_name = current_scene.name
			print(prev_scene_name)
		
		if delete_room == true:
			current_scene.name = "."
			current_scene.queue_free()
			if current_scene == error_scene:
				get_tree().root.get_child(get_index() + 1).queue_free()
		else:
			get_tree().root.remove_child(current_scene)
		
		sceneinitialised.name = prev_scene_name
		
		add_child(sceneinitialised)
		move_child(sceneinitialised, 0)
