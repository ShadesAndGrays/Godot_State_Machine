# @icon("res://addons/GodotStateMachine/state_machine_icon.svg")
@warning_ignore("missing_tool")
extends GodotStateMachine.State

## State to be used on first initialization of the state machine
@export var default_state:GodotStateMachine.State
@export var debug:bool = false

## The state currently being controlled by the state machine
var current_state:GodotStateMachine.State:
	set(value): 
		current_state_transition.emit(str(current_state),str(value))
		current_state = value
## An array containing all loaded states
var all_states = []

## Emitted when transitioning to a new state
signal current_state_transition(old_state:StringName,new_state:StringName)

func _init() -> void:
	pass

func _load_states(state_node):
	if state_node is GodotStateMachine.State:
		state_node.state_name = StringName(state_node.name)
		all_states.append(state_node)
		state_node.transition.connect(_switch_state)
		if debug:
			print("Initialized State .. ",state_node)
	for i in state_node.get_children():
		_load_states(i)


func _ready() -> void:
	if get_children().size() == 0:
		if debug:
			print("No states found")
		return

	for i in get_children():
		_load_states(i)
	if debug:
		print("Loaded States: ",all_states)
	if default_state:
		current_state = default_state
	else:
		current_state = all_states[0]
	# await get_tree().process_frame # Let's just wait one frame
	current_state._enter_state()

func _process_control(delta: float) -> void:
	if current_state:
		current_state._process_control(delta)

func _physic_control(delta: float) -> void:
	if current_state:
		current_state._physic_control(delta)

## Switches the current state to the next state passed to the function [br]
## It calls the exit and entry function of the previous and next state respectively
func  _switch_state(next_state:StringName) -> void:
	for state in all_states:
		if state.state_name.to_lower() == next_state.to_lower():
			if debug:
				print("{0} -> {1}".format([current_state,state]))
			current_state._exit_state()
			current_state = state
			current_state._enter_state()
