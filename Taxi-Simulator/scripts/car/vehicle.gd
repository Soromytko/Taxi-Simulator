extends VehicleBody
class_name Vehicle

signal is_braking_changed(value)

var speed : float setget , get_speed
var seats : Dictionary setget , get_seats

export var engine_power : float = 5.0
export var brake_power : float = 3.0
export var steering_limit : float = 0.5

var _seats : Dictionary
var is_braking : bool setget _set_is_braking, get_is_braking
var _is_braking : bool = false


func get_speed() -> float:
	return linear_velocity.length()


func get_seats() -> Dictionary:
	return _seats


func get_rider(seat_key : String) -> Spatial:
	if _seats.has(seat_key):
		var seat : VehicleSeat = _seats[seat_key]
		return seat.rider
	return null


func has_rider(seat_key : String) -> bool:
	return get_rider(seat_key) != null


func has_driver() -> bool:
	for key in _seats:
		var seat : VehicleSeat = _seats[key]
		if seat.rider != null && seat.is_driver_seat:
			return true
	return false


func set_rider(rider : Spatial, seat_key : String):
	if _seats.has(seat_key):
		var seat : VehicleSeat = _seats[seat_key]
		seat.rider = rider


func remove_rider(seat_key : String):
	set_rider(null, seat_key)


# overridden
func set_brake(value : float):
	.set_brake(value)
	_set_is_braking(value != 0)


func _set_is_braking(value : bool):
	if _is_braking != value:
		_is_braking = value
		emit_signal("is_braking_changed", value)


func get_is_braking() -> bool:
	return _is_braking


#Range from 0 to 1
func press_gas(force : float):
	set_engine_force(engine_power * clamp(force, 0, 1))


func depress_gas():
	set_engine_force(0.0)


#Range from 0 to 1
func press_brake(force : float):
	set_brake(brake_power * clamp(force, 0, 1))


func depress_brake():
	set_brake(0.0)


#Range from -1 to 1
func set_steering_progress(progress : float):
	set_steering(steering_limit * clamp(progress, -1, 1))


func _enter_tree():
	for child in get_children():
		if child is VehicleSeat:
			var seat : VehicleSeat = child
			_seats[seat.key] = seat


func _exit_tree():
	_seats.clear()


