extends BTDecorator
class_name BTBlackboardCondition

enum NotifyType {
	VALUE_CHANGED,
	RESULT_CHANGED,
}

enum ActionType {
	IS_SET,
	IS_NOT_SET,
}

signal reevaluated()

export var _blackboard_key : String = "value_key"
export(int, "Value changed", "Result changed") var _notify_type : int = 0
export(int, "Is set", "Is not set") var _action_type : int = 0
var _last_blackboard_value = null
var _value_property : BTBlackboardProperty


# Overridden
func on_check(_delta : float) -> bool:
	var value = _value_property.value
	if _action_type == ActionType.IS_SET:
		return value != null
	assert(_action_type == ActionType.IS_NOT_SET)
	return value == null


func _on_blackboard_value_changed(value):
	if _notify_type == NotifyType.VALUE_CHANGED || \
		_notify_type == NotifyType.VALUE_CHANGED && \
		_last_blackboard_value != value:
		_last_blackboard_value = value
		emit_signal("reevaluated")


# Overridden
func _on_blackboard_released(blackboard : BTBlackboard):
	_value_property.disconnect("value_changed", self, "_on_blackboard_value_changed")


# Overridden
func _on_blackboard_changed(blackboard : BTBlackboard):
	_value_property = blackboard.get_property(_blackboard_key)
	_value_property.connect("value_changed", self, "_on_blackboard_value_changed")


