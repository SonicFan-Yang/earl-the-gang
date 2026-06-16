extends CharacterBody2D

@export var enabled := true
@export var followimg : CharacterBody2D

var SPEED = 60.0

func _ready() -> void:
	$anim.play("idle")

func _physics_process(delta: float) -> void:

	if enabled:
		velocity = position.direction_to(followimg.position) * SPEED

	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		GameMaster.set_scene("res://scenes/levels/misc./troll_level/troll_2_4_26_r1.tscn", true, false)
