extends VehicleBody

export var roadway_node_path : NodePath

onready var roadway : Roadway = get_node(roadway_node_path)

var _current_waypoint : Waypoint


func _init_current_waypoint():
	_current_waypoint = roadway.get_nearest_waypoint(global_transform.origin)


func _is_reach_current_roadpoint() -> bool:
	if _current_waypoint.global_transform.origin.distance_to(global_transform.origin) < 0.5:
		return true
	var next_waypoint : Waypoint = _get_next_waypoint()
	if next_waypoint == null:
		return false
	var current_waypoint_direction : Vector3 = -_get_direction_to_waypoint(_current_waypoint)
	var new_waypoint_direction : Vector3 = next_waypoint.global_transform.origin - _current_waypoint.global_transform.origin
	var project := current_waypoint_direction.project(new_waypoint_direction)
	return (project + new_waypoint_direction).length() > new_waypoint_direction.length()


func _get_next_waypoint() -> Waypoint:
	push_warning("Override me!")
	return null


func _get_direction_to_current_waypoint() -> Vector3:
	return _current_waypoint.global_transform.origin - global_transform.origin


func _get_direction_to_waypoint(waypoint : Waypoint) -> Vector3:
	return waypoint.global_transform.origin - global_transform.origin


func _get_distance_to_waypoint(waypoint : Waypoint) -> float:
	return global_transform.origin.distance_to(waypoint.global_transform.origin)


func _get_angle_beween_waypoint(waypoint : Waypoint) -> float:
	var direction_to_waypoint := _get_direction_to_waypoint(waypoint)
	var right_direction := global_transform.basis.x
	var angle : float = right_direction.angle_to(direction_to_waypoint)
	return -angle + PI / 2


func _calculate_steering() -> float:
	var direction_to_current_waypoint := _get_direction_to_current_waypoint()
	var right_direction := global_transform.basis.x
	var angle : float = right_direction.angle_to(direction_to_current_waypoint)
	return -angle + PI / 2


