class_name PlayerInput


static func get_move_axes() -> Vector3:
	var input = Vector3.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input.normalized() if input.length() > 1 else input


static func get_steering_axis() -> float:
	var left : float = Input.get_action_strength("steering_left")
	var right : float = Input.get_action_strength("steering_right")
	return right - left


static func get_is_jump() -> bool:
	return Input.get_action_strength("jump") == 1


static func get_is_action() -> bool:
	return Input.is_action_just_pressed("action")


static func get_is_car_forward() -> bool:
	return Input.is_action_pressed("car_forward")


static func get_is_car_back() -> bool:
	return Input.is_action_pressed("car_back")
