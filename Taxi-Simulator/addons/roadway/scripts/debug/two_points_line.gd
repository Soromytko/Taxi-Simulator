tool
extends "./gizmo_line.gd"

var start_point setget set_start_point, get_start_point
var end_point setget set_end_point, get_end_point

export var color : Color setget set_color, get_color
var _color : Color = Color.white
var _start_point
var _end_point


func set_start_point(value):
	_start_point = value


func get_start_point():
	return _start_point


func set_end_point(value):
	_end_point = value


func get_end_point():
	return _end_point


func set_color(value : Color):
	_color = value


func get_color() -> Color:
	return _color


func _get_point_as_vector3(point) -> Vector3:
	if point is Spatial:
		return point.global_transform.origin
	assert(point is Vector3)
	return point


func _process(delta : float):
	if _start_point && _end_point:
		var start := _get_point_as_vector3(_start_point)
		var end := _get_point_as_vector3(_end_point)
		draw(start, end, _color)
