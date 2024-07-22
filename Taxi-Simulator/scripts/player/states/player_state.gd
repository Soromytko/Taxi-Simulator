extends "res://scripts/state_machine/state_machine_state.gd"

export(NodePath) var animator_node_path

onready var _animator : Animator = get_node(animator_node_path)
