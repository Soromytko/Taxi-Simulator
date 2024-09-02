extends Spatial
class_name RWNavigationAgent

export var roadway_name : String setget set_roadway_name, get_roadway_name
var target_position : Vector3 setget set_target_position, get_target_position
var roadway : Roadway
var path_waypoints : Array
var _target_position : Vector3
var _roadway_name : String


func set_roadway_name(value : String):
	if _roadway_name != value:
		_roadway_name = value
		if is_inside_tree():
			_init_roadway()


func get_roadway_name() -> String:
	return _roadway_name


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


func _init_roadway():
	roadway = RWUtils.find_roadway(get_tree(), _roadway_name)


func _enter_tree():
	_init_roadway()
