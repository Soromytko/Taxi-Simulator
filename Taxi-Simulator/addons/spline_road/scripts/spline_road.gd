tool
extends Path

export var resolution : int = 1 setget _set_resolution, get_resolution
var _resolution : int
var _points : Array
var _path_follow : PathFollow
onready var _is_ready : bool = true


func _enter_tree():
	connect("curve_changed", self, "_on_curve_changed")
	_update_points()


func _on_curve_changed():
	_update_points()


func _update_points():
	for point in _points:
		remove_child(point)
		point.queue_free()
	_points.clear()
	var step : float = 1.0 / _resolution
	if _path_follow == null:
		_path_follow = _create_path_follow()
	for i in _resolution + 1:
		_path_follow.unit_offset = step * i
		var point := _create_point()
		point.global_transform.origin = _path_follow.global_transform.origin
		_points.append(point)


func _create_point() -> MeshInstance:
	var result := MeshInstance.new()
	var mesh := CubeMesh.new()
	mesh.size = Vector3.ONE * 0.5
	result.mesh = mesh
	add_child(result)
	return result


func _create_path_follow() -> PathFollow:
	var result : PathFollow = PathFollow.new()
	add_child(result)
	return result



func _set_resolution(value : int):
	value = max(1.0, value)
	if _resolution != value:
		_resolution = value
		if _is_ready:
			_update_points()


func get_resolution() -> int:
	return _resolution
