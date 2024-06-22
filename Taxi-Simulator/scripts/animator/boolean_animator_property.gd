extends AnimatorProperty
class_name BooleanAnimatorProperty


func _init(animator : Animator, name : String, value = false).(animator, name, value):
	pass


func _set_animator_property():
	_animator.set_condition(_name, _value)


func _get_animator_property():
	_value = _animator.get_condition(_name)
