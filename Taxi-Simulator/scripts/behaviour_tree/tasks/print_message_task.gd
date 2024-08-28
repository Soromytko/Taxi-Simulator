extends BTTask
class_name BTPrintMessageTask

export var _message : String


# Overridden
func on_tick(_delta : float) -> int:
	print(_message)
	return TickResult.SUCCESS
