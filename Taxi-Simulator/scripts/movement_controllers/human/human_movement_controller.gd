extends Spatial

export(NodePath) var kinematic_body_node_path
var kinematic_body : KinematicBody setget set_kinematic_body, get_kinematic_body


func _ready():
	kinematic_body = get_node(kinematic_body_node_path)


func set_kinematic_body(value):
	kinematic_body = value


func get_kinematic_body():
	return kinematic_body


func move(var _direction : Vector3, var _delta : float = 1):
	pass



