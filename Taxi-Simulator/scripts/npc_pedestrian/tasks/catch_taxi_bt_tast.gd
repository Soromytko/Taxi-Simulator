extends BTTask

export var _blackboard_taxi_key : String = "visible_taxi"
export var _actor_rotation_speed : float = 5.0
export var _min_distance_to_taxi : float = 2.0
export var _min_taxi_speed : float = 0.2
var _actor_property : BTBlackboardProperty
var _taxi_property : BTBlackboardProperty


# Overridden
func on_tick(delta : float) -> int:
	var actor : Spatial = _actor_property.value
	var taxi : TaxiCar = _taxi_property.value
	if actor && taxi:
		_rotate_actor(actor, taxi.global_transform.origin, delta)
		var taxi_position := taxi.global_transform.origin
		var actor_position := actor.global_transform.origin
		if actor_position.distance_to(taxi_position) < _min_distance_to_taxi:
			if taxi.speed < _min_taxi_speed:
				# start moving towards the taxi
				pass
	return TickResult.FAILURE


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_actor_property = blackboard.get_property(ACTOR_PROPERTY_NAME)
	_taxi_property = blackboard.get_property(_blackboard_taxi_key)


func _get_taxi() -> TaxiCar:
	var maybe_taxi = _blackboard.get_value_or_null(_blackboard_taxi_key)
	if maybe_taxi && maybe_taxi is TaxiCar:
		return maybe_taxi
	return null


func _rotate_actor(actor : Spatial, target : Vector3, delta : float):
	var helper := actor.global_transform.looking_at(target, Vector3.UP)
	var basis := actor.global_transform.basis
	basis = basis.slerp(helper.basis, _actor_rotation_speed * delta)
	actor.global_transform.basis = basis
	actor.rotation.x = 0
	actor.rotation.z = 0
