tool
extends EditorPlugin


const CLASS_ROAD : Script = preload("./scripts/road.gd")
const ROAD_TYPE_NAME := "Road (Road Maker plugin)"


func _enter_tree():
	add_custom_type(ROAD_TYPE_NAME, "Path", CLASS_ROAD, null)


func _exit_tree():
	remove_custom_type(ROAD_TYPE_NAME)
