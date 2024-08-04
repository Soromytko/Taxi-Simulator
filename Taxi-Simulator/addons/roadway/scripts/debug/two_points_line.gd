tool
extends "./gizmo_line.gd"

var start_point : Spatial setget set_start_point, get_start_point
var end_point : Spatial setget set_end_point, get_end_point

export var color : Color setget set_color, get_color
var _color : Color = Color.white
var _start_point : Spatial
var _end_point : Spatial


func set_start_point(value : Spatial):
	_start_point = value


func get_start_point() -> Spatial:
	return _start_point


func set_end_point(value : Spatial):
	_end_point = value


func get_end_point() -> Spatial:
	return _end_point


func set_color(value : Color):
	_color = value


func get_color() -> Color:
	return _color


func _process(delta : float):
	if _start_point != null && _end_point != null:
		draw(_start_point.global_transform.origin, _end_point.global_transform.origin, _color)
	else:
		print(_start_point, _end_point)
