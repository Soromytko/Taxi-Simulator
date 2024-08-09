extends "res://scripts/state_machine/state_machine_state.gd"

export(NodePath) var animator_node_path
export var _interactor_node_path : NodePath

onready var _animator : Animator = get_node(animator_node_path)
onready var _interactor : Interactor = get_node(_interactor_node_path)


func enable_interactor():
	_interactor.set_active(true)
	_interactor.connect("interactable_changed", self, "_on_interactable_changed")


func _disable_interactor():
	_interactor.set_active(false)
	_interactor.disconnect("interactable_changed", self, "_on_interactable_changed")


func _process_interactor():
	if !_interactor.interactable || !PlayerInput.get_is_action():
		return
#	if _interactor.interactable is ComplexInteractable:
#		_switch_state("InteractState")
#	else:
#		_interactor.interact()

