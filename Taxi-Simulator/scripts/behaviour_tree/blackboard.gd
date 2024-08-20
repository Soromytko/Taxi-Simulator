extends Node
class_name BTBlackboard

var _data : Dictionary = {}


func has_key(key : String):
	return _data.has(key)


func get_keys() -> Array:
	return _data.keys()


func set_value(key : String, value):
	_data[key] = value


func erase_value(key : String):
	_data.erase(key)


func get_value(key : String):
	return _data[key]


func get_value_as_int(key : String) -> int:
	return _data[key]


func get_value_as_float(key: String) -> float:
	return _data[key]


func get_value_as_string(key : String) -> String:
	return _data[key]


