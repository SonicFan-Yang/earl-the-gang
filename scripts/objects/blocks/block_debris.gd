extends Node2D

@export var starting_speed : float = 1
@export var debris_nodes : Array[GPUParticles2D]

func _ready() -> void:
	debris_nodes[0].speed_scale = starting_speed
	debris_nodes[1].speed_scale = starting_speed
	debris_nodes[2].speed_scale = starting_speed
	debris_nodes[3].speed_scale = starting_speed
	
	debris_nodes[0].emitting = true
	debris_nodes[1].emitting = true
	debris_nodes[2].emitting = true
	debris_nodes[3].emitting = true
	
	debris_nodes[0].one_shot = true
	debris_nodes[1].one_shot = true
	debris_nodes[2].one_shot = true
	debris_nodes[3].one_shot = true

func _on_grav_timer_timeout() -> void:
	debris_nodes[0].speed_scale = move_toward(debris_nodes[0].speed_scale, 1, 1)
	debris_nodes[1].speed_scale = move_toward(debris_nodes[1].speed_scale, 1, 1)
	debris_nodes[2].speed_scale = move_toward(debris_nodes[2].speed_scale, 1, 1)
	debris_nodes[3].speed_scale = move_toward(debris_nodes[3].speed_scale, 1, 1)

func _on_timer_timeout() -> void:
	$grav_timer.start(1)
