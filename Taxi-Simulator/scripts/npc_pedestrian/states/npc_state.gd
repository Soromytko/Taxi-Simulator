extends StateMachineState

class States:
	const IDLE := "IdleState"
	const WALK := "WalkState"


export var animator_node_path : NodePath
export var _roadway_node_path_str : String
export var roadway_follower_node_path : NodePath

onready var _animator : Animator = get_node(animator_node_path)
onready var _roadway_follower : NPCRoadwayFollower = get_node(roadway_follower_node_path)


func _init_roadway_follower():
	var roadway : Roadway = get_tree().root.get_child(0).get_node_or_null(_roadway_node_path_str)
	if _roadway_follower.roadway != roadway:
		_roadway_follower.roadway = roadway
	_roadway_follower.set_nearest_waypoint_as_current()

