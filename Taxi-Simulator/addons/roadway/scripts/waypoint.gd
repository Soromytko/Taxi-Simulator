tool
extends Position3D
class_name Waypoint

enum WaypointJoinType {
	Back,
	Forward,
	ForwardBack,
}

const CLASS_TWO_POINTS_LINE : Script = preload("./debug/two_points_line.gd")

#Hack to create a button in the inspector
export var add_forward_joined_waypoint : bool setget _add_forward_joined_waypoint_clicked
export var add_forwardback_joined_waypoint : bool setget _add_forwardback_joined_waypoint_clicked
export var add_back_joined_waypoint : bool setget _add_back_joined_waypoint_clicked

export(Array, NodePath) var connected_waypoint_node_paths : Array setget _set_connected_waypoint_node_paths, _get_connected_waypoint_node_paths

var connected_waypoints : Array

var _connected_waypoint_node_paths : Array
var _lines : Array

onready var _is_ready : bool = true


func validate_prev_and_next():
	connected_waypoint_node_paths = _validate_node_paths(connected_waypoint_node_paths)


func append_waypoint_node_path(node_path : NodePath):
	if _try_append_waypoint_node_path(node_path, _connected_waypoint_node_paths, connected_waypoints):
		_commit_connected_waypoint_node_paths()


func _try_append_waypoint_node_path(node_path : NodePath, node_paths : Array, waypoints : Array) -> bool:
	if node_paths.find(node_path) != -1:
		return false
	var maybe_waypoint : Node = get_node_or_null(node_path)
	if !_is_waypoint(maybe_waypoint):
		return false
	if waypoints.find(maybe_waypoint) != -1:
		return false
	node_paths.append(node_path)
	return true


func get_average_offset() -> Vector3:
	var count : int = 0
	var distance : Vector3
	for waypoint in connected_waypoints:
		if waypoint != self:
			distance += waypoint.global_transform.origin - global_transform.origin
			count += 1
	return distance / max(1, count) if distance != Vector3.ZERO else global_transform.basis.z


func get_relative_path() -> String:
	return "../%s" % name


func _set_connected_waypoint_node_paths(value : Array):
	_connected_waypoint_node_paths = _validate_node_paths(value)
	call_deferred("_on_connected_waypoint_node_paths_changed", value)


func _get_connected_waypoint_node_paths() -> Array:
	return _connected_waypoint_node_paths


func _commit_connected_waypoint_node_paths():
	_set_connected_waypoint_node_paths(_connected_waypoint_node_paths)


func _add_forward_joined_waypoint_clicked(is_click : bool):
	_click_add_waypoint(is_click, WaypointJoinType.Forward)


func _add_back_joined_waypoint_clicked(is_click : bool):
	_click_add_waypoint(is_click, WaypointJoinType.Back)


func _add_forwardback_joined_waypoint_clicked(is_click : bool):
	_click_add_waypoint(is_click, WaypointJoinType.ForwardBack)


func _click_add_waypoint(is_click : bool, joinType : int):
	if _is_ready && is_click:
		_create_and_connect_waypoint(joinType)


func _create_waypoint(offset : Vector3) -> Waypoint:
	var waypoint : Waypoint = get_script().new()
	get_parent().add_child(waypoint)
	waypoint.global_transform.origin = global_transform.origin + offset
	waypoint.owner = owner
	waypoint.name = name
	return waypoint


func _connect_waypoint(waypoint : Waypoint, joinType : int):
	var waypoint_node_path : NodePath = waypoint.get_relative_path()
	if joinType == WaypointJoinType.Forward || joinType == WaypointJoinType.ForwardBack:
		append_waypoint_node_path(waypoint_node_path)
	if joinType == WaypointJoinType.Back || joinType == WaypointJoinType.ForwardBack:
		waypoint.append_waypoint_node_path(get_relative_path())


func _create_and_connect_waypoint(joinType : int = WaypointJoinType.ForwardBack):
	var waypoint := _create_waypoint(-get_average_offset())
	_connect_waypoint(waypoint, joinType)


func _on_connected_waypoint_node_paths_changed(value : Array):
	connected_waypoints.clear()
	for waypoint_node_path in value:
		var maybe_waypoint = get_node_or_null(waypoint_node_path)
		if _is_waypoint(maybe_waypoint):
			connected_waypoints.append(maybe_waypoint)
	_update_lines()


func _update_lines():
	if not OS.is_debug_build():
		_release_lines()
		return
	if _lines.size() < connected_waypoints.size():
		for i in range(_lines.size(), connected_waypoints.size(), 1):
			var line := CLASS_TWO_POINTS_LINE.new()
			_lines.append(line)
			add_child(line)
	else:
		for i in range(_lines.size() - 1, connected_waypoints.size() - 1, -1):
			var line : CLASS_TWO_POINTS_LINE = _lines[i]
			line.clear()
			line.queue_free()
			remove_child(line)
		_lines.resize(connected_waypoints.size())
	_set_line_points()


func _release_lines():
	for line in _lines:
		line.queue_free()
	_lines.clear()


func _set_line_points():
	for i in connected_waypoints.size():
		var next_waypoint : Waypoint = connected_waypoints[i]
		var line : CLASS_TWO_POINTS_LINE = _lines[i]
		line.start_point = self
		line.end_point = next_waypoint


func _is_waypoint(maybe_waypoint : Node) -> bool:
	return maybe_waypoint != null && maybe_waypoint.get_script() == get_script()


func _remove_duplicates(array : Array) -> Array:
	var dict : Dictionary
	for value in array:
		dict[value] = value
	return dict.keys()


func _remove_empty_node_paths(node_paths : Array) -> Array:
	return node_paths
	var result : Array
	for node_path in node_paths:
		if node_path is NodePath && !node_path.is_empty() && get_node_or_null(node_path):
			result.append(node_path)
	return result


func _validate_node_paths(node_paths : Array) -> Array:
	return _remove_duplicates(_remove_empty_node_paths(node_paths))

