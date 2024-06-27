tool
extends Position3D
class_name Waypoint

const CLASS_TWO_POINTS_LINE : Script = preload("./debug/two_points_line.gd")

export(Array, NodePath) var prev_waypoint_node_paths : Array setget _set_prev_waypoint_node_paths, _get_prev_waypoint_node_paths
export(Array, NodePath) var next_waypoint_node_paths : Array setget _set_next_waypoint_node_paths, _get_next_waypoint_node_paths

var prev_waypoints : Array
var next_waypoints : Array

var _prev_waypoint_node_paths : Array
var _next_waypoint_node_paths : Array
var _sphere_mesh_instance : MeshInstance
var _lines : Array


func append_next_waypoint_node_path(node_path : NodePath):
	if next_waypoint_node_paths.find(node_path) != -1:
		return
	var maybe_waypoint : Node = get_node_or_null(node_path)
	if not _is_waypoint(maybe_waypoint):
		return
	if next_waypoints.find(maybe_waypoint) == -1:
		_next_waypoint_node_paths.append(node_path)
		_set_next_waypoint_node_paths(_next_waypoint_node_paths)


func validate_prev_and_next():
	prev_waypoint_node_paths = _validate_node_paths(prev_waypoint_node_paths)
	next_waypoint_node_paths = _validate_node_paths(next_waypoint_node_paths)


func _enter_tree():
	if OS.is_debug_build():
		_create_child_sphere_shape()
#	_update_lines()


#func _exit_tree():
#	_sphere_mesh_instance.queue_free()
#	_delete_lines()


func _create_child_sphere_shape():
	_sphere_mesh_instance = MeshInstance.new()
	_sphere_mesh_instance.mesh = SphereMesh.new()
	add_child(_sphere_mesh_instance)
	_sphere_mesh_instance.scale = Vector3.ONE * 0.1


func _set_prev_waypoint_node_paths(value : Array):
	_prev_waypoint_node_paths = _validate_node_paths(value)
	call_deferred("_on_prev_waypoint_node_paths_changed", value)


func _get_prev_waypoint_node_paths() -> Array:
	return _prev_waypoint_node_paths


func _set_next_waypoint_node_paths(value : Array):
	_next_waypoint_node_paths = _validate_node_paths(value)
	call_deferred("_on_next_waypoint_node_paths_changed", value)


func _get_next_waypoint_node_paths() -> Array:
	return _next_waypoint_node_paths


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

