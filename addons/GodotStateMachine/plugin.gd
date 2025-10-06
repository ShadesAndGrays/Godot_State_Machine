@tool
extends EditorPlugin
class_name GodotStateMachine

const State = preload("res://addons/GodotStateMachine/state.gd")
const StateMachine = preload("res://addons/GodotStateMachine/state_machine.gd")

const StateIcon  = preload("res://addons/GodotStateMachine/state_icon.svg")
const StateMachineIcon  = preload("res://addons/GodotStateMachine/state_machine_icon.svg")

var addon_path = "res://addons/GodotStateMachine"
var source_script_template_path = "res://addons/GodotStateMachine/script_templates"
var destination_script_template_path = "res://script_templates"
var cp_files = [
	"State",
	"StateMachine",
	".gdignore"
]

# res://addons/GodotStateMachine/script_templates

func _enable_plugin() -> void:
	# Add autoloads here.
	# print(DirAccess.get_files_at(addon_path))
	if !DirAccess.dir_exists_absolute(destination_script_template_path):
		DirAccess.make_dir_absolute(destination_script_template_path)
	# print(DirAccess.get_directories_at(source_script_template_path))
	var from = DirAccess.open(source_script_template_path)
	# print("copying")
	for path in cp_files: 
		# print(path)
		copy_absolute_recursively(
			"{0}/{1}".format([source_script_template_path,path]),
			"{0}/{1}".format([destination_script_template_path,path])
			)

static func copy_absolute_recursively(from:String,to:String,count = 10):
	if count <= 0:
		print("Hit base condition: Count == 0")
		return

	var path_dir = DirAccess.open(from)
	# print("{0} -> {1}".format([from,to]))

	
	if path_dir != null:
		var src = DirAccess.open(from)
		var out = DirAccess.make_dir_recursive_absolute(to)
		# print("Opened or created", to)
		src.list_dir_begin()
		var file_name = src.get_next()
		while file_name != "":
			# print("file_name: ",file_name)
			copy_absolute_recursively(
				from.path_join(file_name),
				to.path_join(file_name),
				count-1
				)
			file_name = src.get_next()
		src.list_dir_end()
	else:
		DirAccess.copy_absolute(from,to)

func remove_absolute_recursive(path:String,count = 10):
	if count <= 0:
		return
	
	
	var path_dir = DirAccess.open(path)
	if path_dir == null:
			DirAccess.remove_absolute(path)
			return

	path_dir.list_dir_begin()
	var file_name = path_dir.get_next()

	while file_name != "":
		if path_dir.current_is_dir():
			remove_absolute_recursive(path.path_join(file_name),count -1)
		else:
			DirAccess.remove_absolute(path.path_join(file_name))
			
		file_name = path_dir.get_next()
	path_dir.list_dir_end()
	DirAccess.remove_absolute(path)

func _disable_plugin() -> void:
	for path in cp_files: 
		remove_absolute_recursive(
			destination_script_template_path.path_join(path)
			)


func _enter_tree() -> void:
	add_custom_type("State","Node",State,StateIcon)
	add_custom_type("StateMachine","Node",StateMachine,StateMachineIcon)
	pass


func _exit_tree() -> void:
	remove_custom_type("StateMachine")
	remove_custom_type("State")
	# Clean-up of the plugin goes here.
	pass
