tool
extends Position3D
class_name Waypoint

const class_gizmo_line : Script = preload("./debug/gizmo_line.gd")

export var previous_waypoint_node_path : NodePath setget _set_previous_waypoint_node_path, get_previous_point_node_path
export var next_waypoint_node_path : NodePath setget _set_next_waypoint_node_path, get_next_point_node_path

var previous_waypoint : Spatial
var next_waypoint : Waypoint

var _previous_waypoint_node_path : NodePath
var _next_waypoint_node_path : NodePath
var _sphere_mesh_instance : MeshInstance
var _line : class_gizmo_line


func _enter_tree():
	_create_child_sphere_shape()
	_create_line()


func _exit_tree():
	_sphere_mesh_instance.queue_free()
	_line.queue_free()


func _process(delta):
	if next_waypoint != null && next_waypoint.is_inside_tree():
		_line.draw(global_transform.origin, next_waypoint.global_transform.origin, Color.green)
	else:
		_line.clear()


func _create_child_sphere_shape():
	_sphere_mesh_instance = MeshInstance.new()
	_sphere_mesh_instance.mesh = SphereMesh.new()
	add_child(_sphere_mesh_instance)
	_sphere_mesh_instance.scale = Vector3.ONE * 0.1


func _create_line():
	_line = class_gizmo_line.new()
	add_child(_line)


func _set_previous_waypoint_node_path(value : NodePath):
	_previous_waypoint_node_path = value
	call_deferred("_on_previous_waypoint_node_path_changed", value)


func get_previous_point_node_path():
	return _previous_waypoint_node_path


func _set_next_waypoint_node_path(value : NodePath):
	_next_waypoint_node_path = value
	call_deferred("_on_next_waypoint_node_path_changed", value)


func get_next_point_node_path():
	return _next_waypoint_node_path


func _on_previous_waypoint_node_path_changed(value : NodePath):
	if value != null:
		var node = get_node_or_null(value)
		if node != null:
			if node.get_script() == get_script():
				previous_waypoint = node
				return
	previous_waypoint = null


func _on_next_waypoint_node_path_changed(value : NodePath):
	if value != null:
		var node = get_node_or_null(value)
		if node != null:
			if node.get_script() == get_script():
				next_waypoint = node
				return
	next_waypoint = null
