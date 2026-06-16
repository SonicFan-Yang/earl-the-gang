extends "res://scripts/levels/misc./troll/troll_2_4_26_r_1.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	GameMaster.player.modulate = Color(0.0, 0.0, 0.0, 1.0)
	$troll_face.SPEED = 100
