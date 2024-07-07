tool
extends Path

const ROAD_MESHER : Script = preload("./road_mesher.gd")

export var resolution : int = 1 setget _set_resolution, get_resolution
var _resolution : int = 1
var _road_elements : Array
var _path_follow : PathFollow
var _road_mesher : ROAD_MESHER
onready var _is_ready : bool = true


func _enter_tree():
	connect("curve_changed", self, "_on_curve_changed")
	_init_path_follow()
	_init_road_mesher()
	_update_road_elements()


func _exit_tree():
	_release_road_mesher()
	_release_path_follow()


func _on_curve_changed():
	_update_road_elements()


func _update_road_elements():
	for road_element in _road_elements:
		remove_child(road_element)
		road_element.queue_free()
	_road_elements.clear()
	var step : float = 1.0 / _resolution
	for i in _resolution + 1:
		_path_follow.unit_offset = step * i
		var road_element := _create_road_elemet()
		road_element.global_transform.origin = _path_follow.global_transform.origin
		road_element.rotation_degrees = _path_follow.rotation_degrees
		_road_elements.append(road_element)
	_road_mesher.rasterize(_road_elements)


func _create_road_elemet() -> MeshInstance:
	var result := MeshInstance.new()
	var mesh := CubeMesh.new()
	mesh.size = Vector3.ONE * 0.5
	result.mesh = mesh
	add_child(result)
	return result


func _release_child_node(node : Node):
	remove_child(node)
	node.queue_free()


func _init_path_follow():
	_path_follow = PathFollow.new()
	_path_follow.rotation_mode = PathFollow.ROTATION_Y
	add_child(_path_follow)


func _release_path_follow():
	_release_child_node(_path_follow)
	_path_follow = null


func _init_road_mesher():
	_road_mesher = ROAD_MESHER.new()
	add_child(_road_mesher)


func _release_road_mesher():
	_release_child_node(_road_mesher)
	_road_mesher = null


func _set_resolution(value : int):
	value = max(1.0, value)
	if _resolution != value:
		_resolution = value
		if _is_ready:
			_update_road_elements()


func get_resolution() -> int:
	return _resolution
