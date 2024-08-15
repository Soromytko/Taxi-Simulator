extends Control
class_name Map

export var _player_node_path : NodePath
export var _start_point_node_path : NodePath
export var _end_point_node_path : NodePath
onready var _player : Spatial = get_node(_player_node_path)
onready var _start_point : Spatial = get_node(_start_point_node_path)
onready var _end_point : Spatial = get_node(_end_point_node_path)
onready var _map : Control = $ViewportContainer/Viewport/Map/TextureRect

onready var _real_size : Vector2 = _calculate_real_size()


func _calculate_real_size() -> Vector2:
	var size := _end_point.global_transform.origin - _start_point.global_transform.origin
	return Vector2(abs(size.x), abs(size.z))


func _process(delta : float):
	var map_point := _translate_point_to_map(_player.global_transform.origin)
	_map.rect_position = -map_point


func _translate_point_to_map(point : Vector3) -> Vector2:
	var direction := _player.global_transform.origin - _start_point.global_transform.origin
	var offset := Vector2(direction.x, direction.z) / _real_size
	return offset * _map.rect_size * _map.rect_scale - Vector2(150, 200) / 2
