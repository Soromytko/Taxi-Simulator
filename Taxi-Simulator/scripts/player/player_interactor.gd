extends Interactor

onready var _label : Label3D = $"Label3D"


func _ready():
	_label.visible = false


#overridden
func _on_interactable_changed(value : Interactable):
	_update_label()


func _update_label():
	if _label.get_parent():
		_label.get_parent().remove_child(_label)
	if _interactable == null:
		_label.visible = false
	else:
		_interactable.add_child(_label)
		_label.global_transform.origin = _interactable.global_transform.origin
		_label.visible = true
