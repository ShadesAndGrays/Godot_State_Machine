class_name state_machine extends Node

## The state currently being managed by thr state machine
var current_state:state
## State to be used on first initializtion of the state machine
@export var defualt_state:state

var AllStates = []

func _init() -> void:
	pass

func load_states(parent_node):
	if is_instance_of(parent_node,state):
		AllStates.append(parent_node)
		parent_node.State_machine = self
	for i in parent_node.get_children():
		load_states(i)


func _ready() -> void:
	if get_children().size() == 0:
		print("No states found")
		return

	for i in get_children():
		load_states(i)
	print("Loaded States: ",AllStates)
	if defualt_state:
		current_state = defualt_state
	else:current_state = AllStates[0]
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
	for states in AllStates:
		if states.state_name == next_state:
			current_state._exit_state()
			current_state = states
			current_state._enter_state()


