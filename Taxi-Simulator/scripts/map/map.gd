extends Control
class_name Map

class MarkerInitializer:
	var visible : bool
	var offset : Vector2
	var scale : Vector2
	var texture : Texture


var is_ready : bool
export var _player_node_path : NodePath
onready var _player : Spatial = get_node(_player_node_path)
onready var _map : Control = $ViewportContainer/Viewport/Map
onready var _view_container : ViewportContainer = $ViewportContainer
onready var _start_point : Vector3 = $StartPosition3D.global_transform.origin
onready var _end_point : Vector3 = $EndPosition3D.global_transform.origin
onready var _real_size : Vector2 = _calculate_real_size()
var _markers : Dictionary
var _marker_id_counter : int


func _ready():
	is_ready = true


func _process(delta : float):
	var map_point := _translate_point_to_map(_player.global_transform.origin)
	_map.rect_position = - map_point + _view_container.rect_size / 2


func _calculate_real_size() -> Vector2:
	var size := _end_point - _start_point
	return Vector2(abs(size.x), abs(size.z))


func _translate_point_to_map(point : Vector3) -> Vector2:
	var direction := point - _start_point
	var ratio := Vector2(direction.x, direction.z) / _real_size
	return _map.rect_size * _map.rect_scale * ratio


func add_marker(position : Vector3, marker_initializer : MarkerInitializer) -> int:
	var marker_position_2d := _translate_point_to_map(position)
	var marker := _create_marker(marker_position_2d, marker_initializer)
	var id : int = _marker_id_counter
	_markers[id] = marker
	_marker_id_counter += 1
	return id


func remove_marker(id : int):
	if _markers.has(id):
		var marker : Node = _markers[id]
		marker.queue_free()
		_markers.erase(id)


func _create_marker(position : Vector2, marker_initializer : MarkerInitializer) -> Node:
	var marker := MapMarker.new()
	_map.get_node("Markers").add_child(marker)
	marker.visible = marker_initializer.visible
	marker.rect_position = position + marker_initializer.offset
	marker.rect_position_offset = marker_initializer.offset
	marker.rect_pivot_offset = Vector2(0.5, 0.5)
	marker.rect_scale = marker_initializer.scale
	marker.texture = marker_initializer.texture
	return marker


func _get_marker(id : int) -> MapMarker:
	return _markers[id] if _markers.has(id) else null


func set_marker_visible(id : int, marker_visible : bool):
	var marker := _get_marker(id)
	if marker:
		marker.visible = marker_visible


func get_marker_visible(id : int) -> bool:
	var marker := _get_marker(id)
	return marker.visible if marker else false


func set_marker_position_by_tracker(id : int, position : Vector3):
	var marker := _get_marker(id)
	if marker:
		var translated_position = _translate_point_to_map(position)
		marker.rect_position = translated_position + marker.rect_position_offset
