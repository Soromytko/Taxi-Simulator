extends BTTask

export var _roadway_name : String = "roadway_name"
# Blackboard key (write)
export var _blackboard_property_name : String = "target_waypoint"
var _roadway_property : BTBlackboardProperty


# Overridden
func on_tick(_delta : float) -> int:
	var roadway := RWUtils.find_roadway(get_tree(), _roadway_name)
	if roadway:
		var waypoint := _get_random_waypoint(roadway)
		if waypoint:
			_roadway_property.value = waypoint
			return TickResult.SUCCESS
	return TickResult.FAILURE


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_roadway_property = blackboard.get_property(_blackboard_property_name)


func _get_random_waypoint(roadway : Roadway) -> Waypoint:
	var waypoints := roadway._waypoints
	if waypoints.size() == 1:
		return waypoints[0]
	if waypoints.size() > 1:
		var rand_index := TimedRNG.new().randi_range(0, waypoints.size() - 1)
		return waypoints[rand_index]
	return null
