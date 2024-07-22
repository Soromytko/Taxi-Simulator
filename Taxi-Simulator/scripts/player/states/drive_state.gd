extends "./player_state.gd"

export var _player_node_path : NodePath
var vehicle : Vehicle
onready var _player : RiderCharacter = get_node(_player_node_path)


func _on_enter():
	HumanVehicleInteraction.get_into_vehicle_instantly(vehicle, _player)


func _on_physics_update(delta : float):
	if PlayerInput.get_is_action():
		HumanVehicleInteraction.get_out_of_vehicle_instantly(vehicle, _player)
		
