@icon("res://Addons/Godot_State_Machine/state_icon.svg")
class_name State extends Node

var state_name:StringName

## emitted when converting to another state
signal transition(new_state:String)

func _ready() -> void:
	pass
	

## This function runs when the current state has been transitioned into
func _enter_state() -> void:
	pass

## This function that runs in place of _process controlled by the parent state machine
func _process_control(delta:float) -> void:
	pass

## This function that runs in place of _physics_process controlled by the parent state machine
func _physic_control(delta:float) -> void:
	pass

## This function that handles all exit task done before leaving the state
func _exit_state() -> void:
	pass

## This function that handles switching to another state.[br]
## If new state is true, transitioning to the same state will result in not emission of signal.[br]
## If new state is false, transitioning to the same state is equivalent to entering a different state i.e. [code]_exit_state[/code] and [code]_enter_state[/code] will be called.
func switch_to(new_state_name:StringName,only_new_state:bool=true):
	if only_new_state:
		if state_name == new_state_name:
			return
	transition.emit(new_state_name)
	pass

func _to_string() -> String:
	return state_name
