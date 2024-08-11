extends "res://scripts/state_machine/state_machine_state.gd"

export(NodePath) var animator_node_path
export var _interactor_node_path : NodePath

onready var _animator : Animator = get_node(animator_node_path)
onready var _interactor : Interactor = get_node(_interactor_node_path)


func _enable_interactor():
	_interactor.set_active(true)


func _disable_interactor():
	_interactor.set_active(false)


func _process_interactor():
	var interactable := _interactor.interactable
	if !interactable || !PlayerInput.get_is_action():
		return
	var root = get_parent().get_parent()
	interactable.interact(root)

