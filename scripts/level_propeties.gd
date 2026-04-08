extends Node2D
class_name Level

enum level_type {overworld, underground, underwater, sky, castle}
@export var LevelType : level_type

@export var LevelName : String = "insert name of level"
@export var InternalLevelName : String = "insert name of level"
var level_file_location : String = " "

@export var LevelMusic : AudioStreamMP3
@export var music : AudioStreamPlayer2D

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

func _ready():
	
	if LevelMusic && music:
		music.stream = LevelMusic
		music.play()
	
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

		GameMaster.add_child(GameMaster.player)
		GameMaster.player.add_child(GameMaster.camera)

		#GameMaster.ysort_node.remove_child(GameMaster.old_ysort_node)
		#for node in get_children():
			#var node_stored = node
			#node.emit_signal("ready")
		
		GlobalVariable.SCENE_LOADED = false
		level_file_location = scene_file_path.trim_suffix(name + ".tscn")
		print(scene_file_path, ", ", level_file_location, ", ", name)
