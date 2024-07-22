extends "../human_movement_controller.gd"


func move_by_camera_view(direction : Vector3, delta : float):
	var relative_direction : Vector3 = _get_input_axes_relative_to_camera(direction)
	rotate_to_direction(relative_direction, delta)
	move_in_direction(-kinematic_body.global_transform.basis.z, delta)


func move_in_direction_and_rotate(direction : Vector3, delta : float):
	var relative_direction : Vector3 = _get_input_axes_relative_to_camera(direction)
	rotate_to_direction(relative_direction, delta)
	move_in_direction(relative_direction, delta)



func _get_input_axes_relative_to_camera(input_axes : Vector3):
	var camera : Camera = _get_current_camera()
	if camera != null:
		var result := camera.global_transform.basis.x * input_axes.x + \
			camera.global_transform.basis.z * input_axes.z
		result.y = 0
		return result
	return input_axes


func _get_current_camera() -> Camera:
	return get_viewport().get_camera()

