class_name AnimatorProperty

var animator : Animator setget , get_animator
var name : String setget , get_name
var value setget set_value, get_value

var _animator : Animator
var _name : String
var _value


func _init(animator : Animator, name : String, value):
	_animator = animator
	_name = name
	_value = value


func get_animator() -> Animator:
	return _animator


func get_name() -> String:
	return _name


func set_value(value):
	if _value != value:
		_value = value
		_set_animator_property()


func get_value():
	return _value


func update():
	_get_animator_property()


func _set_animator_property():
	push_warning("Override me!")


func _get_animator_property():
	push_warning("Override me!")
