class_name state_machine extends Node

## The state currently being managed by thr state machine
var current_state:state
## State to be used on first initializtion of the state machine
@export var defualt_state:state



func _init() -> void:
	pass

func _ready() -> void:
	if get_children().size() == 0:
		print("No states found")
		return
	for i in get_children():
		if !is_instance_of(i,state):
			printerr("Non state child detected")
			return
		else:
			continue
			pass
	if defualt_state:
		current_state = defualt_state
	else:current_state = get_children()[0]
	current_state._enter_state()
	
	

	

func _process(delta: float) -> void:
	if current_state:
		current_state._process_contorl(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physic_control(delta)

## Switches the current state to the next state passed to the funtion
## It calls the exit and entry function of the previous and next state respectively
func  _switch_state(next_state:StringName)->void:
	for states in get_children():
		if states.state_name == next_state:
			current_state._exit_state()
			current_state = states
			current_state._enter_state()


