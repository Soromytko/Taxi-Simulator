tool
extends Spatial
class_name RWNavigationAgent

const DEFAULT_RADIUS : float = 0.5
const DEFAULT_FRAME_DELAY : int = 20

signal path_points_changed(path_points)

export var roadway_name : String setget set_roadway_name, get_roadway_name
export var target_position : Vector3 setget set_target_position, get_target_position
export var radius : float = DEFAULT_RADIUS setget set_radius, get_radius
# Reduces the path update rate 
export var frame_delay : int = DEFAULT_FRAME_DELAY setget set_frame_delay, get_frame_delay
var roadway : Roadway
var path_points : Array
var _target_position : Vector3
var _roadway_name : String
var _radius : float = DEFAULT_RADIUS
var _frame_delay : int = DEFAULT_FRAME_DELAY
var _initial_distance_to_first_path_point : float
var _frame_counter : int
var _has_path_points_changed : bool


func set_roadway_name(value : String):
	if _roadway_name != value:
		_roadway_name = value
		if is_inside_tree():
			_init_roadway()


func get_roadway_name() -> String:
	return _roadway_name


func set_target_position(value : Vector3):
	_target_position = value


func get_target_position() -> Vector3:
	return _target_position


func set_radius(value : float):
	_radius = value


func get_radius() -> float:
	return _radius


func set_frame_delay(value : int):
	_frame_delay = value


func get_frame_delay() -> int:
	return _frame_delay


func get_next_path_position() -> Vector3:
	_update_path()
	if path_points.size() > 0:
		return path_points[0]
	return global_transform.origin


func get_nearest_waypoint() -> Waypoint:
	return roadway.get_nearest_waypoint(global_transform.origin)


func _update_path():
	if _frame_counter < _frame_delay:
		_frame_counter += 1
		return
	_frame_counter = 0
	if !_check_path():
		_rebuild_path()
	_optimize_path()
	_emit_path_points_if_has_changed()


func _init_roadway():
	roadway = RWUtils.find_roadway(get_tree(), _roadway_name)


func _enter_tree():
	_init_roadway()
	# Randomize the initial value of _frame_counter to distribute the load.
	_frame_counter = TimedRNG.new().randi_range(0, _frame_delay)


# Returns true if the path is correct
# and does not need to be rebuilt.
func _check_path() -> bool:
	return  _is_reach_target_position() || \
			_is_path_built() && \
			_check_path_by_target() && \
			_check_path_by_distance()


func _is_path_built() -> bool:
	return path_points.size() != 0
	

func _check_path_by_target() -> bool:
	return path_points[path_points.size() - 1] == _target_position


func _check_path_by_distance() -> bool:
	var distance := global_transform.origin.distance_to(path_points[0])
	# If the distance to the first point has increased, then rebuild the path.
	# Reduce the value for the error to minimize the chance of path rebuilding.
	var result : bool = distance * 0.9 < _initial_distance_to_first_path_point
	return result


func _rebuild_path():
	var path_waypoints := roadway.build_path(global_transform.origin, _target_position)
	path_points = _convert_wayponts_to_vector3_array(path_waypoints)
	_optimize_last_path_point()
	path_points.append(_target_position)
	_update_initial_distance_to_first_path_point()
	_has_path_points_changed = true


func _convert_wayponts_to_vector3_array(wayponts : Array) -> Array:
	var result := []
	result.resize(wayponts.size())
	for i in wayponts.size():
		result[i] = wayponts[i].global_transform.origin
	return result


func _optimize_last_path_point():
	if path_points.size() >= 1:
		var penultimate_path_position : Vector3 = path_points[path_points.size() - 2]
		var last_path_position : Vector3 = path_points[path_points.size() - 1]
		var first_direction := penultimate_path_position.direction_to(last_path_position)
		var second_direction := last_path_position.direction_to(_target_position)
		var angle := first_direction.angle_to(second_direction)
		if angle >= PI / 2.0:
			path_points.remove(path_points.size() - 1)
			_has_path_points_changed = true


func _update_initial_distance_to_first_path_point():
	if path_points.size() > 0:
		var new_distance := global_transform.origin.distance_to(path_points[0])
		_initial_distance_to_first_path_point = new_distance


func _optimize_path():
	var optimized := false
	if path_points.size() > 0 && _is_reach_first_path_point():
		path_points.remove(0)
		optimized = true
		_has_path_points_changed = true
	elif path_points.size() > 1:
		var first_path_position : Vector3 = path_points[0]
		var second_path_position : Vector3 = path_points[1]
		var direction_to_first := global_transform.origin.direction_to(first_path_position)
		var direction_to_second := global_transform.origin.direction_to(second_path_position)
		var angle := direction_to_first.angle_to(direction_to_second)
		if angle >= PI / 2.0:
			path_points.remove(0)
			optimized = true
			_has_path_points_changed = true
	if optimized:
		_update_initial_distance_to_first_path_point()


func _is_reach_target_position() -> bool:
	return _is_reach_position(_target_position)


func _is_reach_first_path_point() -> bool:
	return _is_reach_position(path_points[0])


func _is_reach_position(position : Vector3) -> bool:
	var distance := global_transform.origin.distance_to(position)
	return distance < _radius || is_zero_approx(distance)


func _emit_path_points_if_has_changed():
	if _has_path_points_changed:
		_has_path_points_changed = false
		emit_signal("path_points_changed", path_points)

