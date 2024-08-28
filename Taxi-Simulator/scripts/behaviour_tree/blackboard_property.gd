class_name BTBlackboardProperty

signal value_changed(value)
var name : String
var value setget set_value, get_value
var _value


func _init(name : String):
	self.name = name


func set_value(new_value):
	if _value != new_value:
		_value = new_value
		emit_signal("value_changed", _value)


func get_value():
	return _value


func get_value_as_int() -> int:
	return _value


func get_value_as_float() -> float:
	return _value


func get_value_as_string() -> String:
	return _value


func get_value_as_vector2() -> Vector2:
	return _value


func get_value_as_Vector3() -> Vector3:
	return _value

