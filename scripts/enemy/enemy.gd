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

@export_category("Base Animation Names")

@export var walk_animation := "walk"
@export var death_animation := "death"

var dead := false

func  _ready() -> void:
	directionX = spawn_facing

func _physics_process(delta: float) -> void:
	if not is_on_floor() && effected_by_gravity == true:
		velocity.y += PlayerScript.GRAVITY
	
	if !dead:
	
		if flip_sprite_to_direction == true:
			sprite.flip_h = (directionX != 1)
		
		velocity.x = directionX * SPEED
		
		if !walks_off_edges:
			if cliff_detectors.size() >= 0:
				if !cliff_detectors[0].is_colliding():
					directionX = 1
				elif !cliff_detectors[1].is_colliding():
					directionX = -1
	
	animation()
	move_and_slide()

func animation():
	if dead == false:
		anim.play(walk_animation)
	else:
		anim.play(death_animation)

func enemy_hit(area):
	var touching = area.owner
	print(area)
	if touching is Player:
		if (area == touching.interaction_point[1] && PlayerScript.velocity.y > 0) && can_be_stomped == true:
			
			dead = true
			touching.movement_node.bounce(-160, 1)
			
		elif area == touching.attack_areas:
			
			dead = true
			collision.set_deferred("disabled", true)
			velocity = Vector2(200 * touching.facing, -200)
			
		elif hurts_player == true:
			touching.movement_node.hit_send()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if dead == false:
		enemy_hit(area)

func _on_wall_body_entered(body: Node2D) -> void:
	print("turn")
	directionX = -directionX
