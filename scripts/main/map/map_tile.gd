@tool
extends Node2D
class_name Map_Tile

var pos = Vector2(0, 0)

@export var going_to = "res://scenes/levels/misc./test.tscn"
@export var title = "test"

@export var TILE : tile
enum tile {active, deactive, secret, pipe}

@onready var sprite = $tile
@onready var debugtext = $debugtext

func _process(delta):
	pos = position
	
	sprite.play(str(TILE))
	debugtext.text = title
