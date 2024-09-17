extends Spatial

var vehicle : Vehicle = null
var navigation_agent : RWNavigationAgent setget set_navigation_agent, get_navigation_agent
var _steer_speed : float = 1.0
var _navigation_agent : RWNavigationAgent


func set_navigation_agent(value : RWNavigationAgent):
	_navigation_agent = value


func get_navigation_agent() -> RWNavigationAgent:
	return _navigation_agent


func move_to(target : Vector3, delta : float, _use_navigation : bool = true) -> bool:
	if _is_reached_target(target):
		return true
	_navigation_agent.target_position = target
	var next_position = _navigation_agent.get_next_path_position()
	_drive(next_position, delta)
	return _is_reached_target(target)


func _is_reached_target(target : Vector3):
	var distance_to_target := global_transform.origin.distance_to(target)
	return distance_to_target < 3.0


func _drive(next_position : Vector3, delta : float):
	if next_position == _navigation_agent.global_transform.origin:
		vehicle.press_brake(2)
		return
	var target_steering = _calculate_steering(next_position)
	vehicle.steering = move_toward(vehicle.steering, target_steering, delta * _steer_speed)
	vehicle.press_gas(1.0)
	vehicle.depress_brake()
	if abs(target_steering) > deg2rad(30):
		var damping := pow(target_steering, 2)
		vehicle.press_brake(vehicle.engine_force * damping)
		vehicle.press_gas(1.0 / damping)


func _calculate_steering(next_position : Vector3) -> float:
	var movement_direction := vehicle.global_transform.origin.direction_to(next_position)
	var right_direction := vehicle.global_transform.basis.x
	var angle : float = right_direction.angle_to(movement_direction)
	return -angle + PI / 2
