extends BTTask
class_name BTPrintWarningTask

export var _warning : String


# Overridden
func on_tick(_delta : float) -> int:
	push_warning(_warning)
	return TickResult.SUCCESS
