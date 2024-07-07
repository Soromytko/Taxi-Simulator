tool
extends Position3D
class_name Waypoint

const CLASS_TWO_POINTS_LINE : Script = preload("./debug/two_points_line.gd")

#Hack to create a button in the inspector
export var add_next_waypoint : bool setget _add_next_waypoint
export var add_prev_waypoint : bool setget _add_prev_waypoint

export(Array, NodePath) var next_waypoint_node_paths : Array setget _set_next_waypoint_node_paths, _get_next_waypoint_node_paths
export(Array, NodePath) var prev_waypoint_node_paths : Array setget _set_prev_waypoint_node_paths, _get_prev_waypoint_node_paths

var next_waypoints : Array
var prev_waypoints : Array

var _prev_waypoint_node_paths : Array
var _next_waypoint_node_paths : Array
var _lines : Array

onready var _is_ready : bool = true


func validate_prev_and_next():
	prev_waypoint_node_paths = _validate_node_paths(prev_waypoint_node_paths)
	next_waypoint_node_paths = _validate_node_paths(next_waypoint_node_paths)


func append_next_waypoint_node_path(node_path : NodePath):
	if _try_append_waypoint_node_path(node_path, _next_waypoint_node_paths, next_waypoints):
		_commit_next_waypoint_node_paths()


func append_prev_waypoint_node_path(node_path : NodePath):
	if _try_append_waypoint_node_path(node_path, _prev_waypoint_node_paths, prev_waypoints):
		_commit_prev_waypoint_node_paths()


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


func get_relative_path() -> String:
	return "../%s" % name


func _set_prev_waypoint_node_paths(value : Array):
	_prev_waypoint_node_paths = _validate_node_paths(value)
	call_deferred("_on_prev_waypoint_node_paths_changed", value)


func _get_prev_waypoint_node_paths() -> Array:
	return _prev_waypoint_node_paths


func _set_next_waypoint_node_paths(value : Array):
	_next_waypoint_node_paths = _validate_node_paths(value)
	call_deferred("_on_next_waypoint_node_paths_changed", value)


func _commit_next_waypoint_node_paths():
	_set_next_waypoint_node_paths(_next_waypoint_node_paths)


func _commit_prev_waypoint_node_paths():
	_set_prev_waypoint_node_paths(_prev_waypoint_node_paths)


func _get_next_waypoint_node_paths() -> Array:
	return _next_waypoint_node_paths


func _add_next_waypoint(value : bool):
	if !_is_ready:
		return
	if value:
		_create_next_waypoint()


func _add_prev_waypoint(value : bool):
	if !_is_ready:
		return
	if value:
		_create_prev_waypoint()


func _create_waypoint(offset : Vector3) -> Waypoint:
	var waypoint : Waypoint = get_script().new()
	get_parent().add_child(waypoint)
	waypoint.global_transform.origin = global_transform.origin + offset
	waypoint.owner = owner
	waypoint.name = name
	return waypoint


func _create_next_waypoint():
	var waypoint := _create_waypoint(global_transform.basis.z)
	var waypoint_node_path : NodePath = waypoint.get_relative_path()
	append_next_waypoint_node_path(waypoint_node_path)
	waypoint.append_prev_waypoint_node_path(get_relative_path())


func _create_prev_waypoint():
	var waypoint := _create_waypoint(-global_transform.basis.z)
	var waypoint_node_path : NodePath = waypoint.get_relative_path()
	append_prev_waypoint_node_path(waypoint_node_path)
	waypoint.append_next_waypoint_node_path(get_relative_path())


func _on_prev_waypoint_node_paths_changed(value : Array):
	prev_waypoints.clear()
	for waypoint_node_path in value:
		var maybe_waypoint = get_node_or_null(waypoint_node_path)
		if _is_waypoint(maybe_waypoint):
			prev_waypoints.append(maybe_waypoint)
	_update_lines()


func _on_next_waypoint_node_paths_changed(value : Array):
	next_waypoints.clear()
	for waypoint_node_path in value:
		var maybe_waypoint = get_node_or_null(waypoint_node_path)
		if _is_waypoint(maybe_waypoint):
			next_waypoints.append(maybe_waypoint)
	_update_lines()


func _update_lines():
	if not OS.is_debug_build():
		_release_lines()
		return
	if _lines.size() < next_waypoints.size():
		for i in range(_lines.size(), next_waypoints.size(), 1):
			var line := CLASS_TWO_POINTS_LINE.new()
			_lines.append(line)
			add_child(line)
	else:
		for i in range(_lines.size() - 1, next_waypoints.size() - 1, -1):
			var line : CLASS_TWO_POINTS_LINE = _lines[i]
			line.clear()
			line.queue_free()
			remove_child(line)
		_lines.resize(next_waypoints.size())
	_set_line_points()


func _release_lines():
	for line in _lines:
		line.queue_free()
	_lines.clear()


func _set_line_points():
	for i in next_waypoints.size():
		var next_waypoint : Waypoint = next_waypoints[i]
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

