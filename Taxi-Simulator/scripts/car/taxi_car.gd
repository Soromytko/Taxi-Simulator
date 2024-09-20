extends Vehicle
class_name TaxiCar


func has_passenger() -> bool:
	for key in _seats:
		var seat : VehicleSeat = _seats[key]
		if !seat.is_driver_seat && seat.rider:
			return true
	return false
