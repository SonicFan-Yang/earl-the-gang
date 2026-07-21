@tool
extends CharacterBody2D
class_name Enemy

enum SpawnDir { Left = -1 , Right = 1 }

enum EnemyBehaviours {
	##Goomba type behaviour.
	Simple,
	##Koopa type, where after it gets stomped something unique happens, it can be set here or in the enemies own code
	Koopa
	}

@export var enemy_behaviour := EnemyBehaviours.Simple

var enemy_hit_sfx = preload("res://audio/sound effects/main/player/enemy_hit.mp3")

var directionX = 0
var Gravity = PlayerScript.GRAVITY
var dead_Gravity = PlayerScript.GRAVITY / 2

@export var SPEED := 20
@export var spawn_facing := SpawnDir.Left

@export var can_be_stomped := true
@export var walks_off_edges := true
@export var effected_by_gravity := true
@export var flip_sprite_to_direction := true
@export var hurts_player := true

@export_category("Nodes")

@export var sprite : Sprite2D
@export var anim : AnimationPlayer
@export var collision : CollisionShape2D
@export var cliff_detectors : Array[RayCast2D]
@export var audio : AudioStreamPlayer2D

@export_category("Base Animation Names")

@export var walk_animation := "walk"
@export var death_animation := "death"

var dead := false
var player_facing := 0

var death_noise := preload("res://audio/sound effects/enemy/bonk-cartoon.mp3")

func  _ready() -> void:
	directionX = spawn_facing

func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		
		if not is_on_floor() && effected_by_gravity == true:
			velocity.y += Gravity
		
		if !dead:
		
			if flip_sprite_to_direction == true:
				sprite.flip_h = (directionX != 1)
			
			if !dead:
				velocity.x = (directionX * SPEED)
			
			if !walks_off_edges:
				if cliff_detectors.size() >= 0:
					if !cliff_detectors[0].is_colliding():
						if cliff_detectors[1].is_colliding():
							directionX = 1
					elif !cliff_detectors[1].is_colliding():
						if cliff_detectors[0].is_colliding():
							directionX = -1
			
		else:
			
			velocity.x = (300 * player_facing) / 2.0
			sprite.flip_h = (velocity.x / abs(velocity.x) == -1)
		
		animation()
		move_and_slide()
	
	else:
		
		sprite.flip_h = (spawn_facing == SpawnDir.Left)

func animation():
	if dead == false:
		anim.play(walk_animation)
	else:
		anim.play(death_animation)

func enemy_hit(area):
	var touching = area.owner
	print(area)
	if touching is Player:
		player_facing = touching.facing
		
		if (area == touching.interaction_point[1] && PlayerScript.velocity.y > 0) && can_be_stomped == true:
			
			dead = true
			touching.movement_node.bounce(-160, 1)
			
		elif area == touching.attack_areas:
			
			dead = true
			collision.set_deferred("disabled", true)
			Gravity = dead_Gravity
			velocity = Vector2(300 * player_facing, -220)
			audio.stream = death_noise
			audio.play()
			
		elif hurts_player == true:
			touching.movement_node.hit_send()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if dead == false:
		enemy_hit(area)

func _on_wall_body_entered(body: Node2D) -> void:
	print("turn")
	directionX = -directionX
