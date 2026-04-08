extends AnimatableBody2D
class_name BaseBlock

##Determines if the block can be broke.
enum break_enum { 
	##Can't break the block.
	Disabled,
	##Can break the block, e.g. like Mario bricks.
	Soft,
	##Can only break in certain ways, e.g. like hard tiles in Mario.
	Hard 
}

@export var enabled : bool = true

@export var breakable : break_enum = break_enum.Disabled

##Check for the block shifting when hit
@export var loose : bool = false

@export_category("Item Container")

@export var hittable : bool
var hit := false

@export var able_to_contain : bool

var velocity := Vector2.ZERO
var constant_force_til_0 := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		velocity += constant_force_til_0
	else:
		velocity = Vector2.ZERO
	position += velocity * delta

func block_hit(area):
	var touching = area.owner
	print(area)
	if touching is Player:
		if area == touching.interaction_point[0] && PlayerScript.velocity.y < 0:
			print("ding")
		elif area == touching.attack_areas:
			print(touching.facing)
			block_bounce(Vector2(touching.facing, 0), 50)
		else:
			print("player")

func block_bounce(dir : Vector2, amount : int):
	constant_force_til_0 = -dir * 6
	velocity = dir * amount

func _on_hitbox_area_entered(area: Area2D) -> void:
	#print(area)
	block_hit(area)
