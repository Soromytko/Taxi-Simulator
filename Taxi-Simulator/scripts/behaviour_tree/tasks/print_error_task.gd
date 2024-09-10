extends BTTask
class_name BTPrintErrorTask

export var _error : String


# Overridden
func on_tick(_delta : float) -> int:
	push_error(_error)
	return TickResult.SUCCESS
