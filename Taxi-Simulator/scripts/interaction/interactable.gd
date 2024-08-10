extends Area
class_name Interactable

signal interacted(some_arg)


func set_active(value : bool):
	monitorable = value


func get_active() -> bool:
	return monitorable


func interact(some_arg = null):
	emit_signal("interacted", some_arg)

