extends Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	ProjectSettings.set_setting("application/config/name", "April Fools!")
	$troll_face.followimg = GameMaster.player
