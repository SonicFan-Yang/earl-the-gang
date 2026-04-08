extends Node

@onready var father : Player = $".."

@onready var attacktimer := $"../attack_timer"

var hover_sound_played := false

func movement(_delta):
	if Input.is_key_pressed(KEY_G):
		father.current_state = father.States.GodMode
	
	#print(father.States.keys()[father.current_state], father.velocity.x > 0)
	if !father.current_state == father.States.GodMode:
	
		if father.current_state == father.States.Normal:
		
			grav_script(0)
			move_script()
			attack_script()
			
			if Input.is_action_just_pressed(father.jump_key):
				jump_script()
				father.current_state = father.States.Jump
		
		elif father.current_state == father.States.Jump:
			
			grav_script(0)
			move_script()
			attack_script()
			jump_script()
		
		elif father.current_state == father.States.Fall:
			
			grav_script(0)
			move_script()
			attack_script()
			jump_script()
		
		elif father.current_state == father.States.Hover:
			
			grav_script(2)
			move_script()
			
			if Input.is_action_just_released(father.jump_key):
			
				father.bouncemultiplier = 0
				if father.jumpcount == 2:
					father.jumpcount = 4
				
				if hover_sound_played == true:
					father.audio.stop()
					hover_sound_played = false
				
				if father.jumpcount <= 1:
					father.P_GRAVITY = father.grav
				
				if father.hovering:
					father.jumpcount = 5
			
			elif not Input.is_action_pressed(father.jump_key):
				
				if hover_sound_played == true:
					father.audio.stop()
					hover_sound_played = false
				
				father.hovering = false
				father.current_state = father.States.Fall
		
		elif father.current_state == father.States.WallSlide:
			
			grav_script(1)
			wallslide_script()
			jump_script(true)
			
		elif father.current_state == father.States.Hurt:
			
			grav_script(4)
	else:
		father.direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		father.velocity = father.direction * 100
		
		for node in get_children():
			if node is CollisionShape2D:
				node.disabled = true
			elif node is Area2D:
				node.monitoring = false
				node.monitorable = false

func move_script():
	
	father.direction.x = Input.get_axis("ui_left", "ui_right")
	#print(father.attacking)
	
	father.attack_areas.scale.x = father.facing
	
	if abs(father.direction.x) == 1:
		father.facing = int(father.direction.x)
	#print((father.velocity.x >= 0 && father.direction.x == -1 || father.velocity.x <= 0 && father.direction.x == 1))
	
	if father.interaction_point[5].has_overlapping_bodies() && father.midair == true:
		for element in father.interaction_point[5].get_overlapping_bodies():
				father.wallsliding = true
				father.current_state = father.States.WallSlide
	else:
		father.wallsliding = false
		father.wallslide_resistance = 0
	
	if father.interaction_point[6].has_overlapping_bodies():
		father.dir_opposite_to_wall = 1
	elif father.interaction_point[7].has_overlapping_bodies():
		father.dir_opposite_to_wall = -1

	#print(father.dir_opposite_to_wall)
	
	#jump_script()
	
	if Input.is_action_pressed(father.run_key):
		father.skidding = false
		if abs(father.velocity.x) >= 250:
			
			father.running = 2
			father.SPEED += 100
			father.MAX_SPEED = 300
			father.velocity.x += father.SPEED * father.facing
			
		elif abs(father.velocity.x) >= 20:
			
			father.running = 1
			father.SPEED = 5
			father.MAX_SPEED = 300
			father.velocity.x += father.SPEED * father.facing
			
		else:
			
			father.running = 0
			father.SPEED = 2
			father.MAX_SPEED = 200
			father.velocity.x += father.SPEED * father.facing
	else:
		
		father.SPEED = father.WALK_SPEED
		father.MAX_SPEED = 93.75
		father.running = 0
		if father.direction.x != 0:
			if father.velocity.x == 0:
				father.velocity.x = father.direction.x * father.MIN_SPEED
			else:
				father.dir = father.direction.x
				father.velocity.x += (father.direction.x * father.SPEED) * 2
				father.skidding = false
			
	if father.is_on_floor():
		if (father.velocity.x >= 0 && father.direction.x == -1 || father.velocity.x <= 0 && father.direction.x == 1):
			
			father.velocity.x = move_toward(father.velocity.x, 0, father.SKID_FRICTION)
			father.skidding = true
	
		elif father.direction.x == 0 || father.attacking == true:
			
			father.SPEED = father.WALK_SPEED
			father.velocity.x = move_toward(father.velocity.x, 0, father.FRICTION)
		
	elif father.direction.x == 0 || father.attacking == true:
		
		father.SPEED = father.WALK_SPEED
		father.velocity.x = move_toward(father.velocity.x, 0, father.FRICTION)
	
	
	#print(father.ATTACKMOVES.keys()[father.attackcurrent])
	
	#print(father.is_on_floor(), father.direction.x == 0, (father.velocity.x >= 0 && father.direction.x == -1 || father.velocity.x <= 0 && father.direction.x == 1))
	
	if father.attacking == false:
		father.velocity.x = clamp(father.velocity.x, -father.MAX_SPEED, father.MAX_SPEED)


func jump_script(is_walljump : bool = false):
	
	if Input.is_action_pressed(father.jump_key):
		
		if Input.is_action_just_pressed(father.jump_key):
			
			#print(jumpcount)
			father.bouncemultiplier = 2
			father.jumping = true
			father.hovering = false
			father.swimming = false
			
			if father.jumpcount <= 1:
				father.P_GRAVITY = father.jump_held_grav
				
				if father.jumpcount == 0:
					
					if is_walljump == false:
						jump(father.JUMPVEL)
						father.audio.stream = father.jump_sound_small
					else:
						jump(father.JUMPVEL)
						father.velocity.x = 100 * father.dir_opposite_to_wall
						print(100 * father.dir_opposite_to_wall)
						father.audio.stream = father.jump_sound_small
						
				elif father.jumpcount == 1:
					jump(father.DOUBJUMPVEL)
					father.audio.stream = father.jump_2_sound
				
				father.audio.play()
				
				father.jumpcount += 1
		
		if father.velocity.y >= 0:
			
			if father.jumpcount > 2:
				father.hovering = true
				father.P_GRAVITY = father.hover_grav
				
				if hover_sound_played == false:
					father.audio.stream = father.hover_sound
					father.audio.play()
					hover_sound_played = true
					print(hover_sound_played, father.audio.stream)
			else:
				if hover_sound_played == true:
					father.audio.stop()
					hover_sound_played = false
				
				if father.jumpcount <= 1:
					father.P_GRAVITY = father.grav
		
	elif Input.is_action_just_released(father.jump_key):
		
		father.bouncemultiplier = 0
		if father.jumpcount == 2:
			father.jumpcount = 4
		
		if hover_sound_played == true:
			father.audio.stop()
			hover_sound_played = false
		
		if father.jumpcount <= 1:
			father.P_GRAVITY = father.grav
		
		if father.hovering:
			father.jumpcount = 5
	
	else:
		
		if hover_sound_played == true:
			father.audio.stop()
			hover_sound_played = false
		
		father.hovering = false
	
	#print(father.velocity.y >= 0)


func grav_script(grav_value : int = 0):
	
	if not father.is_on_floor():
		
		if grav_value != 4:
		
			if grav_value == 0:
				
				father.velocity.y += father.P_GRAVITY
				
			elif grav_value == 1:
				
				father.velocity.y += father.wallslide_resistance + 1
			
			elif grav_value == 2:
				father.velocity.y = father.P_GRAVITY
			
			father.midair = true
			father.swimming = false
			
			if father.swimming == true:
				father.angle = father.velocity.angle()
				father.sprite.rotation = father.angle
			else:
				father.sprite.rotation = 0
			
			father.jumping = !(father.velocity.y >= 0)
			father.falling = (father.velocity.y >= 0)
			
			if father.velocity.y > 0 && not father.hovering:
				father.current_state = father.States.Fall
			elif father.hovering:
				father.current_state = father.States.Hover
		
		else:
			
			father.P_GRAVITY = father.grav
			father.velocity.y += father.P_GRAVITY
	else:
		
		if father.interaction_point[4].has_overlapping_areas():
			if Input.is_action_just_pressed("ui_up"):
				for element in father.interaction_point[4].get_overlapping_areas():
					if str(element).contains("door"):
						GameMaster.set_scene(GameMaster.current_scene.level_file_location + GameMaster.current_scene.InternalLevelName + element.doorid + ".tscn")
		
		if father.attacking:
			if (father.attackcurrent == father.ATTACKMOVES.normhit3start) or (father.attackcurrent == father.ATTACKMOVES.normhit3):
				if father.velocity.x == 0:
					father.attacking = false
					#father.audio.stop()
		
		father.sprite.rotation = 0
		father.angle = 0
		father.midair = false
		
		father.jumping = false
		father.falling = false
		
		father.bouncemultiplier = 0
		father.jumpcount = 0
		father.bounce_processed = 0
		
		father.P_GRAVITY = PlayerScript.GRAVITY
		if father.hurt == false:
			father.velocity.y = 0
			father.current_state = father.States.Normal
		
		if father.anim.current_animation == "hurt":
			father.hurt = false


func attack_script():
	if Input.is_action_just_pressed(father.attack_key) && father.attackmax == false:
		father.direction.x = Input.get_axis("ui_left", "ui_right")
		
		if father.attacking == false:
			
			father.attacking = true
			if not father.midair:
				father.attackcurrent = father.ATTACKMOVES.normhit1
				father.audio.stream = father.attack_whoosh1
			else:
				father.attackcurrent = father.ATTACKMOVES.dashattack
				father.audio.stream = father.attack_whoosh1
			
		else:
			
			match father.attackcurrent:
				father.ATTACKMOVES.normhit1:
					father.attackcurrent = father.ATTACKMOVES.normhit2
					father.audio.stream = father.attack_whoosh2
				father.ATTACKMOVES.normhit2:
					father.attackcurrent = father.ATTACKMOVES.normhit3start
					father.audio.stream = father.attack_whoosh3
					father.attackmax = true
		
		father.audio.play()
		
		if not father.attackcurrent == father.ATTACKMOVES.dashattack:
			if father.attackcurrent != father.ATTACKMOVES.normhit3start:
				father.velocity.x = 40 * father.facing
			else:
				
				if father.direction.x == 0:
					father.velocity = Vector2(93.75 * father.facing, -100)
				else:
					father.velocity = Vector2(125 * father.facing, -120)
		else:
			father.velocity.x = 200 * father.facing


func jump(strength):
	father.velocity.y = strength


func bounce(strength, player_control):
	father.P_GRAVITY = father.grav
	father.bounce_processed = strength + (player_control * (father.bouncemultiplier * -50))
	if father.bouncemultiplier != 0:
		father.P_GRAVITY = father.jump_held_grav
	father.velocity.y = father.bounce_processed
	father.bounce_processed = 0
	#print(str(strength) + " " + str(bounce_processed) + " " + str(bouncemultiplier))
	father.jumpcount = 0


func hit_send():
	if father.current_state != father.States.Hurt:
		get_tree().paused = true
		await get_tree().create_timer(0.05).timeout
		get_tree().paused = false
		father.velocity = father.hit_velocity * Vector2(-father.facing, 1)
		father.hurt = true
		father.current_state = father.States.Hurt


func wallslide_script():
	if father.interaction_point[5].has_overlapping_bodies() && father.midair == true:
		for element in father.interaction_point[5].get_overlapping_bodies():
				father.current_state = father.States.WallSlide
				father.wallsliding = true
				if !father.jumping:
					father.velocity.y = move_toward(father.velocity.y, 40, father.SKID_FRICTION * (father.velocity.y / 50))
					father.wallslide_resistance = 2
					father.jumpcount = 0
				else:
					father.wallslide_resistance = 4
					father.jumpcount = 0
	else:
		father.current_state = father.States.Jump
		father.wallsliding = false
		father.wallslide_resistance = 0
	
	if father.interaction_point[6].has_overlapping_bodies():
		father.dir_opposite_to_wall = 1
	elif father.interaction_point[7].has_overlapping_bodies():
		father.dir_opposite_to_wall = -1


@warning_ignore("unused_parameter")
func _on_wall_l_body_entered(body: Node2D) -> void:
	if father.is_on_wall() && father.midair == true && father.direction:
		print("wallslide start left")
		father.current_state = father.States.WallSlide
		father.wallsliding = true
		father.dir_opposite_to_wall = 1


@warning_ignore("unused_parameter")
func _on_wall_r_body_entered(body: Node2D) -> void:
	if father.is_on_wall() && father.midair == true && father.direction:
		print("wallslide start right")
		father.current_state = father.States.WallSlide
		father.wallsliding = true
		father.dir_opposite_to_wall = -1
