extends AnimatorProperty
class_name BlendAnimatorProperty


func _init(animator : Animator, name : String, value = 0.0).(animator, name, value):
	pass


func _set_animator_property():
	_animator.set_blend_value(_name, _value)


func _get_animator_property():
	_value = _animator.get_blend_value(_name)

