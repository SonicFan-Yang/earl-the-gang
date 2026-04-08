extends Node2D

@export var path = Path2D

var SPEED = 1.5
var direction = 0

var go_to = 0
var has_entered = 0

@onready var hitbox = $hitbox

func _process(delta):
	
	if Input.is_action_just_pressed("ui_left"):
		direction = -1
	elif Input.is_action_just_pressed("ui_right"):
		direction = 1
	
	if direction != 0:
		path.progress += SPEED * direction
	
	if has_entered == 1:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file(go_to)

func _on_hitbox_area_entered(area: Area2D) -> void:
	var touching = area.owner
	if touching is Map_Tile:
		go_to = touching.going_to
		print("entered")
		has_entered = 1

func _on_hitbox_area_exited(area: Area2D) -> void:
	var touching = area.owner
	if touching is Map_Tile:
		print("exitted")
		has_entered = 0
