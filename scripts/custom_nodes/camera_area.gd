@tool
extends Area2D
class_name Camera_Area

@export var area : Vector2 = Vector2(20, 20)

@onready var area_node := $area
@onready var camera_node := $camera

@onready var player := GameMaster.player
@onready var player_camera := GameMaster.camera

func _ready() -> void:
	camera_node.enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	area_node.shape.size = area
	
	if not get_overlapping_bodies():
		for body in get_overlapping_bodies():
			print(body, ", ", player)
			if body == player:
				camera_node.enabled = true
				player_camera.enabled = false
			else:
				camera_node.enabled = false
				player_camera.enabled = true
	else:
		camera_node.enabled = false
		player_camera.enabled = true
		
	
