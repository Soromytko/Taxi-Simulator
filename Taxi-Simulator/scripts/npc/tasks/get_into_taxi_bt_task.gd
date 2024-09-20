extends BTTask

const SEAT_APPROACH_PROPERTY : String = "seat_approach"
const TAXI_PROPERTY : String = "visible_taxi"

var _actor_property : BTBlackboardProperty
var _taxi_property : BTBlackboardProperty
var _seat_approach_property : BTBlackboardProperty


# Overridden
func on_tick(delta : float) -> int:
	var actor : NPC = _actor_property.value
	var taxi : TaxiCar = _taxi_property.value
	var seat_approach : Position3D = _seat_approach_property.value
	if actor && taxi && seat_approach:
		var seat : VehicleSeat = seat_approach.get_parent()
		var target := seat.global_transform.origin
		if actor.rotate_to(target, delta, deg2rad(10.0)):
			CharacterVehicleInteraction.get_into_vehicle_instantly(taxi, actor, seat.key)
			return TickResult.SUCCESS
	else:
		return TickResult.FAILURE
	return TickResult.RUNNING


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_actor_property = blackboard.get_property(ACTOR_PROPERTY_NAME)
	_taxi_property = blackboard.get_property(TAXI_PROPERTY)
	_seat_approach_property = blackboard.get_property(SEAT_APPROACH_PROPERTY)
