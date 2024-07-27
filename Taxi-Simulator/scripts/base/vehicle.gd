extends VehicleBody
class_name Vehicle

signal is_braking_changed(value)

export var engine_power : float = 5.0
export var brake_power : float = 3.0
export var steering_limit : float = 0.5

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
