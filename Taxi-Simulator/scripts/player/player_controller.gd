extends Spatial

var kinematic_body : KinematicBody setget set_kinematic_body, get_kinematic_body


func set_kinematic_body(value):
	kinematic_body = value


func get_kinematic_body():
	return kinematic_body


func move(var _direction : Vector3, var _delta : float = 1):
	pass



