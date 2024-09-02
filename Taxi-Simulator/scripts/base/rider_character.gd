extends "./character.gd"
class_name RiderCharacter


func has_vehicle() -> bool:
	return get_vehicle() != null


func get_vehicle() -> Vehicle:
	push_warning("Override me!")
	return null


func get_into_vehicle_instantly(_vehicle : Vehicle, _vehicle_seat_type : int):
	push_warning("Override me!")


func get_out_of_vehicle_instantly():
	push_warning("Override me!")
