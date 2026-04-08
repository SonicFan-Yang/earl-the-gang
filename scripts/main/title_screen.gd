extends Node2D

enum action { up, down, left, right, jump, run, attack }

var is_remapping := false
var mapping := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_remap_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Window.popup()
	else:
		$Window.hide()

func _on_button_button_up() -> void:
	print("start_button")
	GameMaster.set_scene("res://scenes/levels/misc./troll_level/troll_2_4_26_r1.tscn", false)
	queue_free()
