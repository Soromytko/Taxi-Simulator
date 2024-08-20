extends BTTask
class_name BTPrintMessageTask

export var _message : String


# Overridden
func on_tick(delta : float, actor : Node, blackboard : BTBlackboard) -> int:
	print(_message)
	return TickResult.SUCCESS
