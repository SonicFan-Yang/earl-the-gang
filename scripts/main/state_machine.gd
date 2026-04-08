extends Node

@export var initial_state : State

var states : Array[State]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)
		else:
			push_warning("Woah! Nuh uh uh pal! " + child.name + " isn't a state!")

func can_move():
	return initial_state.can_move
