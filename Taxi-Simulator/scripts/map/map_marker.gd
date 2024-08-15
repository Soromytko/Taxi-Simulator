extends TextureRect
class_name MapMarker

var rect_position_offset : Vector2 setget set_rect_position_offset, get_rect_position_offset
var _rect_position_offset : Vector2


func set_rect_position_offset(value : Vector2):
	_rect_position_offset = value


func get_rect_position_offset() -> Vector2:
	return _rect_position_offset
