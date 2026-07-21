@tool
extends Enemy

func _ready() -> void:
	super()
	$anim.play("walk")

func _physics_process(delta: float) -> void:
	
	$wall/collision.position.x = -0.5 * directionX
	$collision.position.x = -0.5 * directionX
	$hitbox/hitbox.position.x = -2 * directionX
	
	super(delta)

func _on_hitbox_area_entered(area: Area2D) -> void:
	super(area)

func _on_wall_body_entered(body: Node2D) -> void:
	super(body)
