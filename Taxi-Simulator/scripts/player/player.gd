tool
extends KinematicBody

const class_player_controller = preload("./player_controller.gd")
const class_human_player_controller = preload("./human_player_controller/human_player_controller.gd")
# TODO: implementation of driving a car
#const class_car_player_controller = preload("./car_player_controller/car_player_controller.gd")

export(float) var radius = 1.0 setget set_radius, get_radius
export(float) var height = 2.0 setget set_height, get_height

var _human_controller : class_human_player_controller
#var _car_controller : class_car_player_controller
var _current_controller : class_player_controller


func set_radius(value):
	radius = value
	$CollisionShape.shape.radius = radius


func get_radius():
	return radius


func set_height(value):
	height = value
	$CollisionShape.shape.height = height
	$CollisionShape.transform.origin.y = height / 2.0 + 1.0


func get_height():
	return height


#func _process(delta):
#	return

func move_by_camera_view(input_axes : Vector3, delta : float):
	if _current_controller != null:
		var relative_input_axes : Vector3 = _get_input_axes_relative_to_camera(input_axes)
		_current_controller.move(relative_input_axes, delta)


func _get_input_axes_relative_to_camera(input_axes : Vector3):
	var camera : Camera = _get_current_camera()
	if camera != null:
		return camera.transform.basis.x * input_axes.x + \
			camera.transform.basis.z * input_axes.z
	return input_axes	


func _get_current_camera() -> Camera:
	return get_viewport().get_camera()


func _ready():
	_human_controller = class_human_player_controller.new()
	_human_controller.kinematic_body = self
	_current_controller = _human_controller

