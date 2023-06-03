class_name state extends Node

var State_machine:state_machine = null

var state_name:StringName

func _ready() -> void:
	state_name = StringName(name)
	State_machine = get_parent()
	print("State initialized ",state_name)


func _enter_state() ->void:
	pass

func _process_contorl()->void:
	pass

func _physic_control()->void:
	pass

func _exit_state()->void:
	pass
