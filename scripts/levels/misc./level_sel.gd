extends Node2D

@onready var misc = $misc
@onready var lv1 = $lv1

var misc_popup : PopupMenu
var lv1_popup : PopupMenu

func _ready() -> void:
	$ColorRect/Node2D/Parallax2D/ColorRect2.play("spin")
	misc_popup = misc.get_popup()
	lv1_popup = lv1.get_popup()
	misc_popup.id_pressed.connect(misc_input)
	lv1_popup.id_pressed.connect(lv1_input)
	misc.grab_focus()

func misc_input(id : int):
	if id == 0:
		get_tree().change_scene_to_file("res://scenes/levels/misc./test.tscn")
	elif id == 1:
		get_tree().change_scene_to_file("res://scenes/levels/misc./test_player.tscn")

func lv1_input(id : int):
	if id == 0:
		get_tree().change_scene_to_file("res://scenes/levels/world 1/at_the_toptorial.tscn")
