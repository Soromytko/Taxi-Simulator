extends "./character.gd"
class_name RiderCharacter

var is_into_vehicle : bool setget , get_is_into_vehicle
var vehicle : Vehicle setget , get_vehicle
var _vehicle : Vehicle


func get_vehicle() -> Vehicle:
	return _vehicle


func get_is_into_vehicle() -> bool:
	return _vehicle != null


func get_into_vehicle_instantly(_vehicle : Vehicle, _vehicle_seat_type : int):
	push_warning("Override me!")


func get_out_of_vehicle_instantly():
	push_warning("Override me!")
