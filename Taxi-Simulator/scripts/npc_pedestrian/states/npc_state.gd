extends StateMachineState

class States:
	const IDLE := "IdleState"
	const WALK := "WalkState"


export var movement_controller_node_path : NodePath
export var animator_node_path : NodePath
export var roadway_follower_node_path : NodePath

onready var _movement_controller : NPCMovementController = get_node(movement_controller_node_path)
onready var _animator : Animator = get_node(animator_node_path)
onready var _roadway_follower : NPCRoadwayFollower = get_node(roadway_follower_node_path)

