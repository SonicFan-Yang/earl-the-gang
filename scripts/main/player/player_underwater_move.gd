extends Node

@onready var father : Player = $".."

var speed_to_zero = 36

func movement_underwater(_delta):
	
	if father.is_underwater(true):
		
		if father.swimming == false:
			if father.velocity.y > 0:
				father.velocity.y = father.velocity.y / 5
			father.swimming = true
			father.jumpcount = 0
		else:
			
			if Input.is_action_pressed(father.jump_key):
				father.movement_node.jump_script()
	
	if Input.is_action_pressed(father.run_key):
		father.SPEED = 20
	else:
		father.SPEED = father.WALK_SPEED

	father.direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if father.direction:
		father.angle = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").angle()
	else:
		if father.facing == 1:
			father.angle = move_toward(father.angle, 0, 0.25)
		elif father.facing == -1:
			father.angle = move_toward(father.angle, deg_to_rad(180 * (father.angle / abs(father.angle))), 0.25)
	
	if father.direction.x > 0:
		father.facing = 1
	elif father.direction.x < 0:
		father.facing = -1
	
	father.velocity += father.direction * father.SPEED
	
	if father.velocity != Vector2.ZERO:
		father.sprite.rotation = father.angle
	
	#if (father.velocity.x >= 0 && ceili(father.direction.x) == -1 || father.velocity.x <= 0 && ceili(father.direction.x) == 1) || (father.velocity.y >= 0 && ceili(father.direction.y) == -1 || father.velocity.y <= 0 && ceili(father.direction.y) == 1):
		#
		#father.velocity = Vector2(move_toward(father.velocity.x, 0, 1), move_toward(father.velocity.y, 0, 1))
		#print("skid")
		#
	#el
	if father.direction == Vector2.ZERO:
		father.velocity = Vector2(move_toward(father.velocity.x, 0, father.SPEED), move_toward(father.velocity.y, 0, father.SPEED))
	
	father.velocity.x = clamp(father.velocity.x, -father.MAX_SPEED, father.MAX_SPEED)
