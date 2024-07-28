tool
extends Spatial
class_name Roadway

var _waypoints : Dictionary = {}
onready var _is_ready : bool = true
var _astar : AStar = null


func build_path(from : Vector3, to : Vector3) -> Array:
	var from_id := _astar.get_closest_point(from)
	var to_id := _astar.get_closest_point(to)
	var astar_id_path := _astar.get_id_path(from_id, to_id)
	return _correlate_astar_ids_and_waypoints(astar_id_path)


func get_waypoints() -> Array:
	return _waypoints.values()


func get_nearest_waypoint(point : Vector3) -> Waypoint:
	var closest_id := _astar.get_closest_point(point)
	return _waypoints[closest_id]


func _enter_tree():
	_astar = AStar.new()
	_connect_signal("child_entered_tree")
	_connect_signal("child_exiting_tree")


func _exit_tree():
	_disconnect_signal("child_entered_tree")
	_disconnect_signal("child_exiting_tree")


func _on_child_entered_tree(node : Node):
	if node is Waypoint:
		var waypoint : Waypoint = node
		assert(!_has_waypoint(waypoint))
		_add_waypoint(waypoint)
		_add_waypoint_to_astar(waypoint)


func _on_child_exiting_tree(node : Node):
	if node is Waypoint:
		var waypoint : Waypoint = node
		var id := waypoint.id
		assert(_waypoints.has(id))
		_remove_waypoint(id)


func _connect_signal(signal_name : String):
	var method_name := "_on_" + signal_name
	connect(signal_name, self, method_name)


func _disconnect_signal(signal_name : String):
	disconnect(signal_name, self, "_on_" + signal_name)


func _has_waypoint(waypoint : Waypoint):
	for current_waypoint in _waypoints.values():
		if current_waypoint == waypoint:
			return true
	return false


func _add_waypoint(waypoint : Waypoint):
	var id := waypoint.id
	if id == -1 || _waypoints.has(waypoint.id):
		id = _generate_id()
		waypoint._set_id(id)
	_waypoints[id] = waypoint


func _remove_waypoint(id : int):
	_waypoints.erase(id)
	_astar.remove_point(id)


func _add_waypoint_to_astar(waypoint : Waypoint):
	_astar.add_point(waypoint.id, waypoint.global_transform.origin)
	call_deferred("_on_connect_waypoint_to_astar_deffered", waypoint)


func _on_connect_waypoint_to_astar_deffered(waypoint : Waypoint):
	for connected_waypoint in waypoint.connected_waypoints:
		_astar.connect_points(waypoint.id, connected_waypoint.id, false)


func _generate_id() -> int:
	if _waypoints.size() == 0:
		return 0
	return _waypoints.keys().max() + 1


func _correlate_astar_ids_and_waypoints(astar_ids : Array) -> Array:
	var waypoints : Array = []
	waypoints.resize(astar_ids.size())
	for key in _waypoints:
		var waypoint : Waypoint = _waypoints[key]
		var index : int = astar_ids.find(waypoint.id)
		if index >= 0:
			waypoints[index] = waypoint
	return waypoints
