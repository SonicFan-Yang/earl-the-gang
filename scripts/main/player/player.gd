extends CharacterBody2D
class_name Player

enum States { Normal, Jump, Fall, Hover, WallSlide, Attack, Hurt, Death, GodMode }
var current_state := States.Normal

# Player Gravity
var P_GRAVITY = 26.25
var jump_held_grav = 7.5
var water_grav = 1
var grav = 26.25
var hover_grav = 26
var wallslide_resistance = 1

# Adds up to -320
var JUMPVEL = -240
var DOUBJUMPVEL = -190
var bounce_processed = 0

var FRICTION = 3.046875
var SKID_FRICTION = 6.09375

# Adds to 168
var MIN_SPEED = 4.453125
var SPEED = 2.109375
var MAX_SPEED = 93.75
var MAX_RUNSPEED = 93.75

var WALK_SPEED = 2.109375
var RUN_SPEED = 150
var AUTO_WALK_SPEED = 2

var mach1speed = 20
var mach2speed = 225

var hit_velocity := Vector2(150, -200)

## Movement stuff

var midair := false
var jumping := false
var hovering := false
var falling := false
var swimming := false

var wallsliding := false
var dir_opposite_to_wall := 0

var jumpcount = 0
var bouncemultiplier = 0
var landedbutheldjump = 0

var running := 0
var skidding := false

var hurt := false

enum ATTACKMOVES {normhit1, normhit2, normhit3start, normhit3, airuphit, airdownhit, dashattack}
var attackcurrent : ATTACKMOVES = ATTACKMOVES.normhit1
var attacking := false:
	set(value):
		if value == false:
			for i in $attack_areas.get_child_count():
				$attack_areas.get_child(i).set_deferred("disabled", true)
				#print(i)
		attacking = value
var attackmax := false

var dir = 0
var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
var angle = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").angle() + -55
var facing = 1
var attack_area_pos := Vector2.ZERO

## Sounds

var jump_sound_small = preload("res://audio/sound effects/main/player/jump1.wav")
var jump_2_sound = preload("res://audio/sound effects/main/player/jump2.wav")
var hover_sound = preload("res://audio/sound effects/main/player/helicopter.ogg")

var attack_whoosh1 = preload("res://audio/sound effects/main/player/whoosh1.mp3")
var attack_whoosh2 = preload("res://audio/sound effects/main/player/whoosh2.mp3")
var attack_whoosh3 = preload("res://audio/sound effects/main/player/whoosh3spin.mp3")

## @onready's

@onready var sprite : Sprite2D = $sprite2d
@onready var dash_sprite : Sprite2D = $dash_thing2d
@onready var anim : AnimationPlayer = $anim
@onready var run_anim : AnimationPlayer = $dash_thing
@onready var audio : AudioStreamPlayer2D = $audio
@onready var attack_areas : Area2D = $attack_areas
@onready var statemachine := $StateMachine
@onready var skid_partical : GPUParticles2D = $skid_part

## @export's

@export var jump_key := "ui_accept"
@export var run_key := "ui_cancel"
@export var attack_key := "ui_select"
@export var ground_tilemap : TileMapLayer

@export var interaction_point : Array[Area2D]

@export var movement_node : Node
@export var water_movement_node : Node
@export var animation_node : Node

signal door_activate

func _ready() -> void:
	velocity = Vector2.ZERO
	attack_area_pos = attack_areas.position

func _physics_process(delta):
	
	PlayerScript.velocity = velocity
	
	if PlayerScript.game_state == 0:
		
		$power_state_reader.text = str(PlayerScript.POWER_STATE.keys()[PlayerScript.power_state])
		
		#print(facing)
		
		if is_underwater() == true:
			water_movement_node.movement_underwater(delta)
		else:
			movement_node.movement(delta)
		
		#print(direction)
		
		animation_node.animation(facing)
	elif PlayerScript.game_state == 3:
		
		velocity.x = AUTO_WALK_SPEED
	
	move_and_slide()

func is_underwater(check_for_rim := false):
	if ground_tilemap != null:
		var data := ground_tilemap.get_cell_tile_data(ground_tilemap.local_to_map(position))
		if data:
			if check_for_rim == false:
				return data.get_custom_data("water")
			else:
				return data.get_custom_data("water_rim")
