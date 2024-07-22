extends VehicleBody
class_name Vehicle

signal is_braking_changed(value)

var _riders : Dictionary = {}
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
	_riders[VehicleSeat.Type.LeftFrontDriver] = driver


func remove_driver():
	if !_riders.erase(VehicleSeat.Type.LeftFrontDriver):
		var arg : String = VehicleSeat.Type.keys()[VehicleSeat.Type.LeftFrontDriver]
		push_warning("The driver is missing: %s" % arg)


func has_driver() -> bool:
	return _riders.has(VehicleSeat.Type.LeftFrontDriver)


func press_gas(force : float):
	set_engine_force(force)


func depress_gas():
	set_engine_force(0.0)


func press_brake(force : float):
	set_brake(force)


func depress_brake():
	set_brake(0.0)
