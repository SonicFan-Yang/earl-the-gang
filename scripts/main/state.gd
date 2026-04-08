extends Node
class_name State

signal transition

@export var can_move : bool

func Ready():
	pass

func Free():
	pass

func Process(delta: float):
	pass

func Physics_Process(delta: float):
	pass
