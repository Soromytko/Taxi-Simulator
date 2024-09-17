extends "./character.gd"
class_name RiderCharacter


func has_vehicle() -> bool:
	return get_vehicle() != null


func get_vehicle() -> Vehicle:
	push_warning("Override me!")
	return null


func get_is_driver() -> bool:
	var maybe_seat = get_parent()
	if maybe_seat is VehicleSeat:
		var seat : VehicleSeat = maybe_seat
		return seat.is_driver_seat
	return false


func get_into_vehicle_instantly(_vehicle : Vehicle, _seat_key : String):
	push_warning("Override me!")


func get_out_of_vehicle_instantly():
	push_warning("Override me!")
