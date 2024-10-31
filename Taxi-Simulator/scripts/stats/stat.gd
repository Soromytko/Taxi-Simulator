extends Node
class_name Stat

signal current_value_changed(value)

const DEFAULT_VALUE : float = 100.0

export var current_value : float = DEFAULT_VALUE setget set_current_value, get_current_value
export var min_value : float = 0.0
export var max_value : float = 100.0
var _current_value : float = DEFAULT_VALUE


func set_current_value(value : float):
	value = clamp(value, min_value, max_value)
	if _current_value != value:
		_current_value = value
		emit_signal("current_value_changed", value)
		

func get_current_value() -> float:
	return _current_value


func increate_current_value(value : float):
	set_current_value(_current_value + value)

