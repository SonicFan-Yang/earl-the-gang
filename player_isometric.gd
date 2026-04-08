extends CharacterBody2D

var SPEED = 50

func _physics_process(delta):
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		velocity = round(direction) * SPEED
	else:
		velocity = Vector2.ZERO
	
	#print(round(direction))
	
	move_and_slide()
