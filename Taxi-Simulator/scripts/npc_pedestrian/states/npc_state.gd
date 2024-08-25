extends StateMachineState

class States:
	const IDLE := "IdleState"
	const WALK := "WalkState"


export var animator_node_path : NodePath
export var _roadway_node_path_str : String
export var roadway_follower_node_path : NodePath
export var _interactable_node_path : NodePath
export var _vision_area_node_path : NodePath
onready var _animator : Animator = get_node(animator_node_path)
onready var _roadway_follower : RoadwayFollower = get_node(roadway_follower_node_path)
onready var _interactable : Interactable = get_node(_interactable_node_path)
onready var _vision_area : Area = get_node(_vision_area_node_path)


func _init_roadway_follower():
	var roadway : Roadway = get_tree().root.get_child(0).get_node_or_null(_roadway_node_path_str)
	if _roadway_follower.roadway != roadway:
		_roadway_follower.roadway = roadway


func set_random_target_position():
	var roadway := _roadway_follower.roadway
	var waypoints := roadway._waypoints
	var rand_index := TimedRNG.new().randi_range(0, waypoints.size() - 1)
	var waypoint : Waypoint = waypoints[rand_index]
	_roadway_follower.target_position = waypoint.global_transform.origin


func _enable_interactable():
	_interactable.set_active(true)
	_interactable.connect("interacted", self, "_on_interacted")


func _disable_interactable():
	_interactable.set_active(false)
	_interactable.disconnect("interacted", self, "_on_interacted")


func _enable_vision():
	_vision_area.connect("body_entered", self, "_on_vision_body_entered")
	_vision_area.connect("body_exited", self, "_on_vision_body_exited")


func _disable_vision():
	_vision_area.disconnect("body_entered", self, "_on_vision_body_entered")
	_vision_area.disconnect("body_exited", self, "_on_vision_body_exited")


func _on_interacted(some_arg):
	print("Hi! My name is %s" % get_parent().get_parent().name)


func _on_vision_body_entered(body : PhysicsBody):
	push_warning("Override me! %s" % body)


func _on_vision_body_exited(body : PhysicsBody):
	push_warning("Override me! %s" % body)


func _get_character() -> RiderCharacter:
	var character : RiderCharacter = get_parent().get_parent()
	return character

