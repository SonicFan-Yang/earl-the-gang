extends Node

@export var father : Player
var last_anim := ""
var double_jump_roll := false

func animation(direction):
	
	if father.jumpcount <= 1:
		double_jump_roll = false
	
	father.skid_partical.position.x = -7 * father.facing
	father.skid_partical.scale.x = -father.facing
	father.skid_partical.emitting = (father.skidding)
	
	if father.hurt == false:
	
		if father.attacking == false:
			
			father.attackmax = false
			
			father.dash_sprite.position.x = 12 * father.facing
			father.dash_sprite.flip_h = (direction < 0)
			if father.running >= 2:
				father.run_anim.play("dash_active")
			else:
				father.run_anim.play("dash_deactive")
			
			if father.midair == false:
				
				if father.velocity.x != 0 && father.jumping == false:
					
					if father.jumping == false:
						father.sprite.flip_h = (direction < 0)
					
					if father.skidding == false:
						father.anim.speed_scale = father.velocity.x / 100
						if father.running == 0:
							father.anim.play("walk")
						else:
							father.anim.play("mach" + str(father.running))
					else:
						father.anim.play("skid")
					
				else:
					
					father.sprite.flip_h = (father.facing < 0)
					father.anim.speed_scale = 1
					if father.direction.y <= 0:
						father.anim.play("idle")
					else:
						father.anim.play("crouch")
					
			else:
				father.anim.speed_scale = 1
				
				if father.swimming == false:
				
					father.sprite.flip_v = false
					
					if !father.wallsliding:
				
						if father.jumping == true:
							
							if father.jumpcount <= 1:
								father.anim.play("jump")
							else:
								if double_jump_roll == true:
									father.anim.play("doublejump")
								else:
									father.anim.play("doublejumpstart")
							
						elif father.falling == true:
							#print(father.jumpcount, ", ", father.hovering)
							if father.hovering == false:
								if father.jumpcount <= 1 or father.jumpcount == 3:
									father.anim.play("fall")
							else:
								father.anim.play("hover")
					
					else:
						father.sprite.flip_h = (direction < 0)
						father.anim.play("wallslide")
			
				else:
					
					if father.velocity != Vector2.ZERO:
						father.sprite.flip_v = (direction < 0)
						father.anim.play("swim_idle")
					else:
						father.anim.play("idle")
		else:
			
			father.anim.speed_scale = 1
			father.anim.play(father.ATTACKMOVES.keys()[father.attackcurrent])
			#print(father.anim.current_animation, " ", father.anim.animation)
		
	else:
		
		father.anim.play("hurt")

func _on_sprite_animation_finished() -> void:
	if last_anim == father.ATTACKMOVES.keys()[father.attackcurrent] + "_" + str(PlayerScript.power_state):
		if father.ATTACKMOVES.keys()[father.attackcurrent] == "normhit3start":
			father.attackcurrent = father.ATTACKMOVES.normhit3
		else:
			father.attacking = false

func _on_anim_animation_finished(anim_name: StringName) -> void:
	#print(anim_name)
	if anim_name == father.ATTACKMOVES.keys()[father.attackcurrent]:
		#print(father.ATTACKMOVES.keys()[father.attackcurrent] == "normhit3start")
		if anim_name == "normhit3start":
			father.attackcurrent = father.ATTACKMOVES.normhit3
		else:
			father.attacking = false
	elif anim_name == "doublejumpstart":
		double_jump_roll = true
