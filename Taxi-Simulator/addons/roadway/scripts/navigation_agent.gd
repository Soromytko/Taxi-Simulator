extends Spatial

var target_position : Vector3 setget set_target_position, get_target_position
var roadway : Roadway
var path_waypoints : Array
var _target_position : Vector3


func set_target_position(value : Vector3):
	_target_position = value


func get_target_position() -> Vector3:
	return _target_position


func get_next_path_position() -> Vector3:
	_update_path()
	# TODO: Don't take into account the first path position,
	# because it may be behind the character.
	# This is the wrong behavior.
	if path_waypoints.size() > 1:
		return path_waypoints[1].global_transform.origin
	return global_transform.origin


func get_nearest_waypoint() -> Waypoint:
	return roadway.get_nearest_waypoint(global_transform.origin)


func _update_path():
	# TODO: Rebuilding the path every tick is not an optimal solution.
	path_waypoints = roadway.build_path(global_transform.origin, target_position)

