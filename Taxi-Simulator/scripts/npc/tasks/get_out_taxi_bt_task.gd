extends BTTask

const TAXI_PROPERTY : String = "visible_taxi"

var _actor_property : BTBlackboardProperty
var _taxi_property : BTBlackboardProperty


# Overridden
func on_tick(delta : float) -> int:
	var actor : RiderCharacter = _actor_property.value
	var taxi : TaxiCar = _taxi_property.value
	CharacterVehicleInteraction.get_out_of_vehicle_instantly(taxi, actor)
	return TickResult.SUCCESS


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_actor_property = blackboard.get_property(ACTOR_PROPERTY_NAME)
	_taxi_property = blackboard.get_property(TAXI_PROPERTY)
	

