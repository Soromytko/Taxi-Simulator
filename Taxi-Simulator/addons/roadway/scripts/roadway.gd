tool
extends Spatial
class_name Roadway

var _waypoints : Array = []
onready var _is_ready : bool = true


func get_nearest_waypoint(point : Vector3) -> Waypoint:
	var last_distance : float = INF
	var result : Waypoint = null
	for waypoint in _waypoints:
		var distance : float = waypoint.global_transform.origin.distance_to(point)
		if distance < last_distance:
			result = waypoint
			last_distance = distance
	return result


func _enter_tree():
	_connect_signal("child_entered_tree")
	_connect_signal("child_exiting_tree")


func _on_child_entered_tree(node : Node):
	if node is Waypoint:
		assert(_waypoints.find(node) == -1)
		_waypoints.append(node)


func _on_child_exiting_tree(node : Node):
	if node is Waypoint:
		var index := _waypoints.find(node)
		assert(index >= 0)
		_waypoints.remove(index)
#	_disconnect_signal("child_entered_tree")
#	_disconnect_signal("child_exiting_tree")


func _connect_signal(signal_name : String):
	var method_name := "_on_" + signal_name
	connect(signal_name, self, method_name)


func _disconnect_signal(signal_name : String):
	disconnect(signal_name, self, "_on_" + signal_name)
