class_name state_machine extends Node

var current_state:state_temp
@export var defualt_state:state_temp



func _init() -> void:
	pass

func _ready() -> void:
	current_state = defualt_state

func _process(delta: float) -> void:
	current_state._process_contorl()

func _physics_process(delta: float) -> void:
	current_state._physic_control()

func  _switch_state(next_state:StringName)->void:
	for states in get_children():
		if states.state_name == next_state:
			await current_state._exit_state()
			current_state = states
			current_state._enter_state()


class state_temp extends Node:
	var State_machine:state_machine = null
	
	var state_name:StringName
	func _enter_state() ->void:
		pass
	func _process_contorl()->void:
		pass
	func _physic_control()->void:
		pass
	func _exit_state()->void:
		pass
