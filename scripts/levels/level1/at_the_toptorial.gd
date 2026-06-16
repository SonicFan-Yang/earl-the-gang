extends Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	GameMaster.player.modulate = $shadowed.modulate
	$background/background2.modulate = $shadowed.modulate
	$background/background3.modulate = $shadowed.modulate
