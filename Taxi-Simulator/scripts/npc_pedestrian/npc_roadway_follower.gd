extends RoadwayFollower
class_name NPCRoadwayFollower

export var _roadway_path_in_root : String
onready var _rng := TimedRNG.new()
var _next_waypoint : Waypoint


func _ready():
	roadway = get_tree().root.get_child(0).get_node_or_null(_roadway_path_in_root)
	current_waypoint = roadway.get_nearest_waypoint(global_transform.origin)
	call_deferred("_init_next_waypoint")


func _init_next_waypoint():
	_next_waypoint = _get_random_next_waypoint(current_waypoint)


func _get_next_waypoint() -> Waypoint:
	return _next_waypoint


func set_next_waypoint_if_reached():
	if _is_reach_current_roadpoint():
		var next_waypoint := _next_waypoint
		_next_waypoint = _get_random_next_waypoint(next_waypoint)
		current_waypoint = next_waypoint


func _get_random_next_waypoint(waypoint : Waypoint) -> Waypoint:
	if waypoint == null || waypoint.connected_waypoints.size() == 0:
		return null
	var suitable_waypoints : Array
	for iter_waypoint in waypoint.connected_waypoints:
		if iter_waypoint != current_waypoint:
			suitable_waypoints.append(iter_waypoint)
	if suitable_waypoints.size() < 1:
		return null
	var index := _rng.randi_range(0, suitable_waypoints.size() - 1)
	return suitable_waypoints[index]

