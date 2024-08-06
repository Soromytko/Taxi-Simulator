extends Area
class_name Interactor

signal interactable_changed(interactable)
signal interactable_revealed(interactable)
signal interactable_not_revealed()

var interactable : Interactable setget _set_interactable, get_interactable

var _interactable : Interactable


func interact():
	if _interactable:
		_interactable.interact()


func _set_interactable(value : Interactable):
	if _interactable != value:
		_interactable = value
		_on_interactable_changed(value)
		emit_signal("interactable_changed")


func get_interactable() -> Interactable:
	return _interactable


func _enter_tree():
	_connect_signals()
	_reveal_interactable()


func _exit_tree():
	_reveal_interactable()
	_disconnect_signals()


func _on_area_entered(area : Area):
	if area is Interactable:
		_reveal_interactable()


func _on_area_exited(area : Area):
	if area is Interactable:
		_reveal_interactable()


func _on_interactable_changed(value : Interactable):
	pass


func _reveal_interactable():
	var interactable := _find_best_interactable_with_camera()
	_set_interactable(interactable)


func _get_interactables() -> Array:
	var result := []
	for area in get_overlapping_areas():
		if area is Interactable:
			result.append(area)
	return result


func _find_best_interactable(observer : Spatial) -> Interactable:
	var interactables := _get_interactables()
	if interactables.size() == 0:
		return null
	var best_angle : float = 2 * PI;
	var best_interactable : Interactable = interactables[0]
	for current_interactable in interactables:
		var v1 : Vector3 = current_interactable.global_transform.origin - observer.global_transform.origin
		var v2 : Vector3 = -observer.global_transform.basis.z
		var angle := v1.angle_to(v2)
		if angle < best_angle:
			best_angle = angle
			best_interactable = current_interactable
	return best_interactable


func _find_best_interactable_with_camera() -> Interactable:
	var camera := _get_current_camera()
	if !camera:
		return null
	return _find_best_interactable(camera)


func _connect_signals():
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")


func _disconnect_signals():
	disconnect("area_entered", self, "_on_area_entered")
	disconnect("area_exited", self, "_on_area_exited")


func _get_current_camera() -> Camera:
	return get_viewport().get_camera()
