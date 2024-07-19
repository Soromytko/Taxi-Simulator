extends VehicleBody
class_name CarNPC

signal is_braking_changed(value)
var is_braking : bool setget _set_is_braking, get_is_braking
onready var _state_machine : StateMachine = $StateMachine
onready var _roadway_follower : RoadwayFollower = $RoadayFollower
var _is_braking : bool = false


func start_walking():
	if _state_machine.current_state_name != "WalkState":
		_state_machine.switch_state("WalkState")
	else:
		_roadway_follower.set_nearest_waypoint_as_current()


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

