extends "../human_movement_controller.gd"

var move_speed : float = 5
var rotation_speed : float = 3

var _move_speed_multiplier = 100

var _velocity : Vector3


func move(var direction : Vector3, var delta : float = 1):
	if kinematic_body == null:
		return
	var speed : float = move_speed * _move_speed_multiplier * delta
	_velocity.x = direction.x * speed
	_velocity.z = direction.z * speed
	_velocity = kinematic_body.move_and_slide(_velocity, Vector3.UP)


func move_to_forward(speed : float = 1):
	var direction := -kinematic_body.global_transform.basis.z
	move(direction, speed)


func _rotate_to_direction(direction : Vector3, delta : float = 1):
	if kinematic_body == null:
		return
	var rotation_target = atan2(-direction.x, -direction.z)
	kinematic_body.rotation.y = lerp_angle(kinematic_body.rotation.y, rotation_target, rotation_speed * delta)


func move_by_camera_view(input_axes : Vector3, delta : float):
	var relative_input_axes : Vector3 = _get_input_axes_relative_to_camera(input_axes)
	move_to_forward(delta)
#	move(relative_input_axes, delta)
	_rotate_to_direction(relative_input_axes, delta * 2)


func _get_input_axes_relative_to_camera(input_axes : Vector3):
	var camera : Camera = _get_current_camera()
	if camera != null:
		return camera.global_transform.basis.x * input_axes.x + \
			camera.global_transform.basis.z * input_axes.z
	return input_axes


func _get_current_camera() -> Camera:
	return get_viewport().get_camera()

