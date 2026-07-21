extends Sprite2D

@export var curve : Curve

var velocity := Vector2.ZERO
var travel := 0.0

func _physics_process(delta: float) -> void:
	travel += delta
	
	velocity = Vector2(curve.sample(travel), 0).direction_to(Vector2.RIGHT)
	
	position += velocity * delta
