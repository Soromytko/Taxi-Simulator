extends "./npc_state.gd"

var vehicle : Vehicle = null
var _steer_speed : float = 1.0


func _on_enter():
	_init_roadway_follower()


func _on_physics_update(delta : float):
	if _roadway_follower.current_waypoint == null:
		return
	_drive(delta)
	_roadway_follower.set_next_waypoint_if_reached()


func _drive(delta : float):
	var target_steering = _calculate_steering()
	vehicle.steering = move_toward(vehicle.steering, target_steering, delta * _steer_speed)
	vehicle.press_gas(4)
	vehicle.depress_brake()
	if abs(target_steering) > deg2rad(30):
		var damping := pow(target_steering, 2)
		vehicle.press_brake(vehicle.engine_force * damping)
		vehicle.press_gas(4.0 / damping)


func _calculate_steering() -> float:
	var direction_to_current_waypoint := _roadway_follower._get_direction_to_current_waypoint()
	var right_direction := vehicle.global_transform.basis.x
	var angle : float = right_direction.angle_to(direction_to_current_waypoint)
	return -angle + PI / 2
