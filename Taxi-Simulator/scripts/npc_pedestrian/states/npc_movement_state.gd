extends "./npc_state.gd"

export var movement_controller_node_path : NodePath
onready var _movement_controller : NPCMovementController = get_node(movement_controller_node_path)

