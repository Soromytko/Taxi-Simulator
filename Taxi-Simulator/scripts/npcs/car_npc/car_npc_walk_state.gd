extends "./car_npc_state.gd"

export var _car_roadway_follower_node_path : NodePath
onready var _car_roadway_follower : RoadwayFollower = get_node(_car_roadway_follower_node_path)

var _steer_speed : float = 1.0


func _on_enter():
	_car_roadway_follower.set_nearest_waypoint_as_current() 


func _on_physics_update(delta : float):
	if _car_roadway_follower.current_waypoint == null:
		return
	_drive(delta)
	_car_roadway_follower.set_next_waypoint_if_reached()


func _drive(delta : float):
	var target_steering = _car_roadway_follower.calculate_steering()
	_car_body.steering = move_toward(_car_body.steering, target_steering, delta * _steer_speed)
	_car_body.engine_force = 4
	_car_body.set_brake(0)
	if abs(target_steering) > deg2rad(30):
		var damping := pow(target_steering, 2)
		_car_body.set_brake(_car_body.engine_force * damping)
		_car_body.engine_force = 4.0 / damping

