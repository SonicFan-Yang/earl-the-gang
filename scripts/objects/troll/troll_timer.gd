extends CanvasLayer

var time_left := 0

@onready var timer_node : Timer = $Timer
@onready var text_node : RichTextLabel = $RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time_left = round(timer_node.time_left)
	text_node.text = "[shake rate=100.0 level=20 connected=1][wave amp=50.0 freq=5.0 connected=1][color=ff0000]" + str(time_left / 60) + ":" + str(time_left - 60)
	
