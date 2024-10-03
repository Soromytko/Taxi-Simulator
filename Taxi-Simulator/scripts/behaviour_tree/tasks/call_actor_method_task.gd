extends BTTask
class_name BTCallActorMethodTask

var _actor_property : BTBlackboardProperty

export var _method_name : String


# Overridden
func on_tick(_delta : float) -> int:
	var actor : Spatial = _actor_property.value
	if actor:
		if actor.has_method(_method_name):
			actor.call(_method_name)
			return TickResult.SUCCESS
	return TickResult.FAILURE


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_actor_property = blackboard.get_property(ACTOR_PROPERTY_NAME)

