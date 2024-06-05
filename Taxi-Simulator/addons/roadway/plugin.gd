tool
extends EditorPlugin

const ROADWAY_SCRIPT : Script = preload("./scripts/roadway.gd")
const class_waypoint : Script = preload("./scripts/waypoint.gd")
const vehicle_traffic_type_name : String = "Roadway"
const waypoint_type_name : String = "Waypoint"
const icon = preload("./resources/icon.png")


#func _enter_tree():
#	add_custom_type(vehicle_traffic_type_name, "Spatial", ROADWAY_SCRIPT, null)
#	add_custom_type(waypoint_type_name, "Position3D", class_waypoint, null)
#
#
#func _exit_tree():
#	remove_custom_type(vehicle_traffic_type_name)
#	remove_custom_type(waypoint_type_name)
