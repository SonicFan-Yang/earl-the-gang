extends PhysicsBody2D
class_name BaseBlock

##If you want the block to bounce, keep this enabled.
@export var enabled : bool = true

@export_category("Item Container")

@export var hittable : bool
var hit := false

@export var able_to_contain : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func block_hit(area):
	var touching = area.owner
	print(area)
	if touching is Player:
		if area == touching.interaction_point[0] && PlayerScript.velocity.y < 0:
			if has_node("BlockBounce"):
				$BlockBounce.block_bounce(Vector2(0, -1))
		elif area == touching.attack_areas:
			print(touching.facing)
			if has_node("BlockBounce"):
				$BlockBounce.block_bounce(Vector2(touching.facing, 0))
		else:
			print("player")

func _on_hitbox_area_entered(area: Area2D) -> void:
	#print(area)
	if hittable == true:
		block_hit(area)
