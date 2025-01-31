extends "res://scripts/player/state.gd"

#referencia al timer
@onready var CoyoteTimer = $CoyoteTimer
@export var coyote_duration = .2 #tiempo del coyote time
var can_jump = true
var duble_jump = 1
#desde FALL puede entrar a 
#IDLE, DASH, SLIDE, JUMP
func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.get_next_to_wall() != null:
		return STATES.SLIDE
	if Player.jump_input_actuation and can_jump:
		return STATES.JUMP
	#if Player.velocity.y > 0 and duble_jump <= 1 and Player.jump_input_actuation:
		#return STATES.JUMP
	
	return null

func enter_state():
	#si el estado anterior es IDLE, MOVE o SLIDE puede saltar  
	if Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE:
		can_jump = true
		CoyoteTimer.start(coyote_duration) #inica el timer
	else: 
		can_jump = false

func _on_coyote_timer_timeout():
	can_jump = false #desactiva el salto cuando se acaba el timer
	
	
