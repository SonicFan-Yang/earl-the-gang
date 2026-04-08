extends Enemy

func _physics_process(delta):
	
	super(delta)
	
	animation()

func animation():
	if dead == false:
		sprite.play("goomba_walk")
	else:
		sprite.play("goomba_dead")

func _on_hitbox_area_entered(area: Area2D) -> void:
	super(area)

func _on_wall_body_entered(body: Node2D) -> void:
	super(body)
