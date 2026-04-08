extends Node

var up : InputEvent
var down : InputEvent
var left : InputEvent
var right : InputEvent
var jump : InputEvent
var run : InputEvent
var attack : InputEvent

#General

var GRAVITY = 26.25

#Player

enum POWER_STATE {small = 0, big = 1, fire = 2, star = 3}
enum GAME_STATE {normal, swim, flag_grab, post_grab}

var power_state : POWER_STATE
var game_state : GAME_STATE
var STATE

var velocity = Vector2(0, 0)
