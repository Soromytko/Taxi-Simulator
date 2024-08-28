extends BTTask
class_name BTMoveToTask

export var _blackboard_property_name : String
const MOVE_TO_METHOD_NAME : String = "move_to"
var _actor_property : BTBlackboardProperty
var _target_property : BTBlackboardProperty


func on_tick(delta : float) -> int:
	var actor = _actor_property.value
	if actor.has_method(MOVE_TO_METHOD_NAME):
		var target := _get_target(actor)
		if actor.call(MOVE_TO_METHOD_NAME, target, delta):
			return TickResult.SUCCESS
		else:
			return TickResult.RUNNING
	return TickResult.FAILURE


func _get_target(actor : Spatial) -> Vector3:
	var variant_target = _target_property.value
	if variant_target is Vector3:
		return variant_target
	elif variant_target is Spatial:
		return variant_target.global_transform.origin
	return actor.global_transform.origin


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_actor_property = blackboard.get_property(ACTOR_PROPERTY_NAME)
	_target_property = blackboard.get_property(_blackboard_property_name)

