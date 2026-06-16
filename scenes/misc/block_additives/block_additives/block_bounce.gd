extends Node

enum break_enum { 
	##Can't break the block.
	Disabled,
	##Can break the block, e.g. like Mario bricks.
	Soft,
	##Can only break in certain ways, e.g. like hard tiles in Mario.
	Hard 
}

##Determines if the block can be broke.
@export var breakable : break_enum = break_enum.Disabled

##Check for the block shifting when hit
@export var can_shift : bool = true

@export var gravity := Vector2.ZERO
@export var initial_bounce_yspeed := 100

@export var sprite : Sprite2D

var velocity := Vector2.ZERO
var start_pos := Vector2.ZERO

var bounce_dir := Vector2.ZERO
var bounce := false

func _ready() -> void:
	start_pos = owner.global_position

func _physics_process(delta: float) -> void:
	if sprite:
		if $bounce.is_stopped():
			bounce = false
			sprite.global_position = start_pos
			velocity += Vector2.ZERO
		else:
			sprite.position += velocity * delta
			velocity += gravity

func block_bounce(dir : Vector2):
	if breakable == break_enum.Soft:
		var block_debris : Node2D = preload("res://scenes/misc/block_additives/block_debris.tscn").instantiate()
		for element in owner.get_children():
			if element is Node2D and element != block_debris:
				element.queue_free()
		#block_debris.global_position = owner.global_position
		owner.add_child(block_debris)
	
	if bounce == false:
		bounce = true
		bounce_dir = dir
		gravity = -bounce_dir * 17
		velocity = bounce_dir * initial_bounce_yspeed
		$bounce.start()
