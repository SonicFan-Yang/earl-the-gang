extends CanvasLayer

@onready var anim = $anim

signal fade_end
signal unfade_end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameMaster.connect("fade_start", fade_start)
	GameMaster.connect("unfade_start", unfade_start)

func fade_start():
	GlobalVariable.if_pause_n_unpause(true)
	anim.play("fade_in")
	await anim.animation_finished
	print("fade in end")
	fade_end.emit()
	GlobalVariable.if_pause_n_unpause(false)

func unfade_start():
	anim.play("fade_iout")
	await anim.animation_finished
	print("fade out end")
	unfade_end.emit()
	GlobalVariable.if_pause_n_unpause(false)
