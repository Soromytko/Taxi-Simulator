extends BTBehaviourNode
class_name BTBlackboardBehaviourNode

const ACTOR_PROPERTY_NAME := "actor"

var _blackboard : BTBlackboard


func set_blackboard(value : BTBlackboard):
	if _blackboard != value:
		if _blackboard != null:
			_on_blackboard_released(_blackboard)
		_blackboard = value
		_on_blackboard_changed(_blackboard)


func _on_blackboard_released(blackboard : BTBlackboard):
	pass


func _on_blackboard_changed(blackboard : BTBlackboard):
	pass

