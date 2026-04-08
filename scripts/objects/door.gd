@tool
extends Area2D
class_name Door

@export var sprite_list : SpriteFrames = preload("res://resourses/animations/doors.tres")
@export var door : StringName = "troll"

@export var go_to_location := ""
@export var doorid := &""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$sprite.sprite_frames = sprite_list
	$sprite.animation = door
	
	if not Engine.is_editor_hint():
		pass
