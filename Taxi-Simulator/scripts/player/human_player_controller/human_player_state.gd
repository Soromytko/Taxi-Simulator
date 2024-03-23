extends "res://scripts/state_machine/state_machine_state.gd"

const class_player_input = preload("../player_input.gd")

export(NodePath) var player_node_path

onready var _player = get_node(player_node_path) 

