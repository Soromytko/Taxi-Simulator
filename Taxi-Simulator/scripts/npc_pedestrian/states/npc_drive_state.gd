extends "./npc_state.gd"

var vehicle : Vehicle = null
var _steer_speed : float = 1.0


func _on_enter():
	_init_roadway_follower()


func _on_physics_update(delta : float):
	var next_position = _roadway_follower.get_next_path_position()
	_drive(delta, next_position)


func _drive(delta : float, next_position : Vector3):
	if next_position == _roadway_follower.global_transform.origin:
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
	var movement_direction := _roadway_follower.global_transform.origin.direction_to(next_position)
	var right_direction := vehicle.global_transform.basis.x
	var angle : float = right_direction.angle_to(movement_direction)
	return -angle + PI / 2
