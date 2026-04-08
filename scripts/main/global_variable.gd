extends Node

var fake_y = 0

var character_portrait = ""
var dialogue_finished = 0
var in_menu = 0 #0 = no, 1 = yes

var using_fightboat = false

@export var input_accept = "accept"

@export var NAME = "Name"
@export var LV = 1
@export var HP = 20
@export var MAXHP = 20
@export var ATK = 1
@export var DEF = 1
@export var G = 0
@export var EXP = 0
@export var EXP_til_NEXT = 0

##Scene Master Thangs

var SCENE
var POSITION
var SCENE_LOADED = false

var game_start = false

var JSON_ = JSON.new()

func save():
	pass
