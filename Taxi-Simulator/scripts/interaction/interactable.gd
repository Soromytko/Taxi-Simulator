extends Area
class_name Interactable

signal interacted()


#func interact(args : Dictionary = {}):
#	pass

func interact(interactor = null):
	emit_signal("interacted", interactor)


func set_enabled(value : bool):
	monitorable = value
