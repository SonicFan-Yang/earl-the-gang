extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameMaster.set_scene("res://scenes/levels/misc./troll_level/troll_2_4_26_r1.tscn", true, false)
