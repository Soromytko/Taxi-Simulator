tool
extends EditorPlugin


const CLASS_SPLINE_ROAD : Script = preload("./scripts/spline_road.gd")
const SPLINE_ROAD_TYPE_NAME := "SplineRoad"


func _enter_tree():
	add_custom_type(SPLINE_ROAD_TYPE_NAME, "Spatial", CLASS_SPLINE_ROAD, null)


func _exit_tree():
	remove_custom_type(SPLINE_ROAD_TYPE_NAME)
