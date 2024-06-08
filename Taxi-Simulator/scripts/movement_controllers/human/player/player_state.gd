extends "res://scripts/state_machine/state_machine_state.gd"

const class_player_input : Script = preload("res://scripts/player/player_input.gd")
const class_movement_controller : Script = preload("res://scripts/movement_controllers/human/player/player_movement_controller.gd")

export(NodePath) var movement_controller_node_path
export(NodePath) var animator_node_path

onready var _movement_controller : class_movement_controller = get_node(movement_controller_node_path) 
onready var _animator : Animator = get_node(animator_node_path)

var _idle_walk_blend_value : float


func _on_enter():
	_idle_walk_blend_value = _animator.get_blend_value("idle_walk")
