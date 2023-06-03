class_name state_machine extends Node

var current_state:state
@export var defualt_state:state

func _init() -> void:
	pass

func _ready() -> void:
	if defualt_state:
		current_state = defualt_state
	else:current_state = get_children()[0]
	current_state._enter_state()

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


