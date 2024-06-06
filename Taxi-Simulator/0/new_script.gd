tool
extends Spatial


func _process(delta):
	var car : Spatial = $Car
	var current_waypoint : Spatial = $CurrentWaypoint
	var next_waypoint : Spatial = $NextWaypoint
	var debug : Spatial = $Debug
	
	
	var v1 : Vector3 = car.global_transform.origin - current_waypoint.global_transform.origin
	var v2 : Vector3 = next_waypoint.global_transform.origin - current_waypoint.global_transform.origin
	var p : Vector3 = v1.project(v2)
	debug.global_transform.origin = current_waypoint.global_transform.origin + p
