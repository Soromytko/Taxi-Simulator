extends Spatial
class_name Tracker

const VISIBLE_ON_MAP_DEFAULT_VALUE := true
const TRACKING_DEFAULT_VALUE := true

export var visible_on_map : bool = VISIBLE_ON_MAP_DEFAULT_VALUE setget set_visible_on_map, get_visible_on_map
export var tracking : bool = TRACKING_DEFAULT_VALUE setget set_tracking, get_tracking
export var map_name : String setget set_map_name, get_map_name
export var _marker_texture : Texture
export var _marker_offset : Vector2 = Vector2.ZERO
export var _marker_scale : Vector2 = Vector2.ONE
var _visible_on_map : bool = VISIBLE_ON_MAP_DEFAULT_VALUE
var _tracking : bool = TRACKING_DEFAULT_VALUE
var _map_name : String
var _map : Map
var _marker_id : int = -1


func _ready():
	set_notify_transform(true)
	_set_map(_find_map())


func _process(delta):
	if _map && _tracking:
		_map.set_marker_position_by_tracker(_marker_id, global_transform.origin)


func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		if _map && _tracking:
			_map.set_marker_position_by_tracker(_marker_id, global_transform.origin)


func set_visible_on_map(value : bool):
	if value != _visible_on_map:
		_visible_on_map = value
		if _map:
			_map.set_marker_visible(_marker_id, value)


func get_visible_on_map() -> bool:
	return _map.get_marker_visible(_marker_id) if _map else _visible_on_map


func set_tracking(value : bool):
	_tracking = value


func get_tracking() -> bool:
	return _tracking


func set_map_name(value : String):
	if value != _map_name:
		_map_name = value
		if is_inside_tree():
			_set_map(_find_map())


func get_map_name():
	return _map_name


func _find_map() -> Map:
	var maybe_maps := get_tree().get_nodes_in_group("maps")
	for maybe_map in maybe_maps:
		if maybe_map is Map && maybe_map.name == _map_name:
			return maybe_map
	return null


func _set_map(value : Map):
	if value != _map:
		if _map:
			# The map node is probably ready.
			_map.remove_marker(_marker_id)
		_map = value
		if !_map:
			return
		var marker_initializer := _create_marker_initializer()
		if !_map.is_ready:
			call_deferred("add_marker", marker_initializer)
		else:
			add_marker(marker_initializer)


func add_marker(marker_initializer : Map.MarkerInitializer):
	_marker_id = _map.add_marker(global_transform.origin, marker_initializer)
	

func _create_marker_initializer() -> Map.MarkerInitializer:
	var result := Map.MarkerInitializer.new()
	result.visible = _visible_on_map
	result.offset = _marker_offset
	result.scale = _marker_scale
	result.texture = _marker_texture
	return result

