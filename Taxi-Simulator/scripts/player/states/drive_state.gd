extends "./player_state.gd"

export var _player_node_path : NodePath
var vehicle : Vehicle
onready var _player : RiderCharacter = get_node(_player_node_path)
var _steering : float = 0.0
var _steering_speed : float = 5.0


func _on_enter():
	HumanVehicleInteraction.get_into_vehicle_instantly(vehicle, _player)


func _on_physics_update(delta : float):
	if PlayerInput.get_is_action():
		HumanVehicleInteraction.get_out_of_vehicle_instantly(vehicle, _player)
		return
	
	if PlayerInput.get_is_car_forward():
		vehicle.press_gas(1.0)
	else:
		vehicle.depress_gas()
		
	if PlayerInput.get_is_car_back():
		vehicle.press_brake(1.0)
	else:
		vehicle.depress_brake()
	
	var steering_target : float = PlayerInput.get_steering_axis()
	_steering = move_toward(_steering, steering_target, delta * _steering_speed)
	vehicle.set_steering_progress(-_steering)
