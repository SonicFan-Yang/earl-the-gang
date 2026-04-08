extends Node2D
class_name Map

var SPEED = 0.05

var follow_parent = 0
var path = 0
var last_path = 0

var changed_path = 0

@export var follow : PathFollow2D
@export var player : Node2D

func  _ready() -> void:
	follow_parent = follow.get_parent()
	
	check_path(1)

func _physics_process(delta):
	
	follow_parent = follow.get_parent()
	
	
	if follow.progress_ratio == 1:
		check_path(1)
		if player.direction == 1:
			reparenting()
			player.direction = 0
			follow.progress = 0
	elif follow.progress_ratio <= 0.07:
		check_path(-1)
		if player.direction == -1:
			reparenting()
			player.direction = 0
			follow.progress = 1
	

func check_path(dir):
	last_path = path
	if follow_parent == $Paths/path:
		if dir == -1:
			path = 1
		elif dir == 1:
			path = 2
	elif follow_parent == $Paths/path2:
		if dir == -1:
			path = 1
		elif dir == 1:
			path = 3
	elif follow_parent == $Paths/path3:
		if dir == -1:
			path = 2
		elif dir == 1:
			path = 3
	print(path)

# if path != path the players moving forward, vise versa

func reparenting():
	if path == 1:
		follow.reparent($Paths/path1)
	elif path == 2:
		follow.reparent($Paths/path2)
	elif path == 3:
		follow.reparent($Paths/path3)
