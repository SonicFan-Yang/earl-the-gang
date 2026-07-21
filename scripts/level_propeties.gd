extends Node2D
class_name Level

enum level_type {overworld, underground, underwater, sky, castle}
@export var LevelType : level_type

@export var LevelName : String = "insert name of level"
@export var InternalLevelName : String = "insert name of level"
var level_file_location : String = " "

@export var LevelMusic : AudioStreamMP3
@export var change_lvl_music : bool = true

var camera : Camera2D

@export var player_spawner : Node2D
@export var npc : Node2D

@export var y_sort : Node2D

@export_category("Camera Properties")

@export var offset : Vector2 = Vector2(0, 0)
@export var zoom : Vector2 = Vector2(1, 1)
@export var limit_l : int = -10000000
@export var limit_r : int = 10000000
@export var limit_u : int = -10000000
@export var limit_d : int = 10000000

@export var create_left_wall := true
var left_wall = StaticBody2D.new()
var left_coll = CollisionShape2D.new()
var l_n_r_shape = RectangleShape2D.new()

func _ready():
	#left wall creation
	if create_left_wall == true:
	
		l_n_r_shape.size = Vector2(100, abs(limit_u) + abs(limit_d))
		left_coll.shape = l_n_r_shape
		
		@warning_ignore("integer_division")
		left_wall.position = Vector2(limit_l - 50, (limit_u + limit_d) / 2)
		
		left_wall.add_child(left_coll)
		add_child(left_wall)
	
	
	if LevelMusic && change_lvl_music:
		ConstantMusic.stream = LevelMusic
		ConstantMusic.play()
	
	if GlobalVariable.SCENE_LOADED == true:
		player_spawner.hide()
		
		GlobalVariable.dialogue_finished = 0

		GameMaster.player.position = player_spawner.position
		GameMaster.player.velocity = Vector2.ZERO
		
		if npc:
			npc.player = GameMaster.player

		GameMaster.camera.offset = offset
		GameMaster.camera.zoom = zoom
		GameMaster.camera.limit_left = limit_l
		GameMaster.camera.limit_right = limit_r
		GameMaster.camera.limit_top = limit_u
		GameMaster.camera.limit_bottom = limit_d

		GameMaster.subviewport.add_child(GameMaster.player)
		GameMaster.player.add_child(GameMaster.camera)

		#GameMaster.ysort_node.remove_child(GameMaster.old_ysort_node)
		#for node in get_children():
			#var node_stored = node
			#node.emit_signal("ready")
		
		GlobalVariable.SCENE_LOADED = false
		DisplayServer.window_set_title(LevelName)
		level_file_location = scene_file_path.trim_suffix(name + ".tscn")
		print(scene_file_path, ", ", level_file_location, ", ", name)
