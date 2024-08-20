extends BTTask
class_name BTWaitTask

export var _time : float = 1.0
var _timer : float = 0.0


# Overridden
func on_tick(delta : float, actor : Node, blackboard : BTBlackboard) -> int:
	_timer += delta
	if _timer >= _time:
		_timer = 0.0
		return TickResult.SUCCESS
	return TickResult.RUNNING

