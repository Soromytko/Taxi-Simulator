extends BTTask

const TAXI_PROPERTY : String = "visible_taxi"
const DESTINATION_PROPERTY : String = "target_waypoint"

const MIN_DISTANCE_TO_DESTINATION : float = 5.0

var _actor_property : BTBlackboardProperty
var _taxi_property : BTBlackboardProperty
var _destination_property : BTBlackboardProperty

var _actor : Spatial
var _taxi : TaxiCar
var _destination : Vector3


# Overridden
func on_tick(delta : float) -> int:
	var distance := _actor.global_transform.origin.distance_to(_destination)
	if distance < MIN_DISTANCE_TO_DESTINATION:
		if _taxi.speed < 1.0:
			return TickResult.SUCCESS
	return TickResult.RUNNING


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_desconnect_properties()
	_actor_property = blackboard.get_property(ACTOR_PROPERTY_NAME)
	_taxi_property = blackboard.get_property(TAXI_PROPERTY)
	_destination_property = blackboard.get_property(DESTINATION_PROPERTY)
	_connect_properties()
	_on_actor_property_changed(_actor_property.value)
	_on_taxi_property_changed(_taxi_property.value)
	_on_destination_property_changed(_destination_property.value)


func _connect_properties():
	if _actor_property: _actor_property.connect("value_changed", self, "_on_actor_property_changed")
	if _taxi_property: _taxi_property.connect("value_changed", self, "_on_taxi_property_changed")
	if _destination_property: _destination_property.connect("value_changed", self, "_on_destination_property_changed")


func _desconnect_properties():
	if _actor_property: _actor_property.disconnect("value_changed", self, "_on_actor_property_changed")
	if _taxi_property: _taxi_property.disconnect("value_changed", self, "_on_taxi_property_changed")
	if _destination_property: _destination_property.disconnect("value_changed", self, "_on_destination_property_changed")


func _on_actor_property_changed(value : RiderCharacter):
	_actor = value


func _on_taxi_property_changed(value : TaxiCar):
	_taxi = value


func _on_destination_property_changed(value):
	if value is Vector3:
		_destination = value
	elif value is Spatial:
		_destination = value.global_transform.origin
	else:
		_destination = Vector3.ZERO

