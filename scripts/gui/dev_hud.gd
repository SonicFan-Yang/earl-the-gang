extends CanvasLayer

var game_state_meaning := "Normal"

var room_id := ""

@onready var text = $text
@onready var text2 = $text2
@onready var text3 = $text3

@onready var room_id_tb : TextEdit = $room_id

@export var player : Player

func _process(delta):
	pass
	#text.text = "vel.x = " + str(round_place(PlayerScript.velocity.x, 2)) + "\nvel.y = " + str(round_place(PlayerScript.velocity.y, 2)) + "\nfacing = " + str(player.facing)
	#text2.text = "game state = " + str(PlayerScript.GAME_STATE.keys()[PlayerScript.game_state])
	#text3.text = "on rim? " + str(player.is_underwater(true)) + "\nswimming? " + str(player.swimming) + "\nangle = " + str(player.angle)

func round_place(num,places):
	return (round (num * pow(10, places)) / pow(10,places))

func _on_button_pressed() -> void:
	GameMaster.set_scene(GameMaster.current_scene.level_file_location + GameMaster.current_scene.InternalLevelName + room_id + ".tscn")
	$Button.release_focus()

func _on_room_id_text_changed() -> void:
	room_id = room_id_tb.text
