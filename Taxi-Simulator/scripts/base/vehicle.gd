extends VehicleBody
class_name Vehicle

signal is_braking_changed(value)

var _passengers : Dictionary = {}
var is_braking : bool setget _set_is_braking, get_is_braking
var _is_braking : bool = false


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


func set_driver(driver : Spatial):
	_passengers[VehicleSeat.Type.RightFrontDriver] = driver


func has_driver() -> bool:
	return _passengers.has(VehicleSeat.Type.RightFrontDriver)


func press_gas(force : float):
	set_engine_force(force)


func depress_gas():
	set_engine_force(0.0)


func press_brake(force : float):
	set_brake(force)


func depress_brake():
	set_brake(0.0)
