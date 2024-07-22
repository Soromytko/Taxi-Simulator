extends "./movement_player_state.gd"


func _on_physics_update(delta : float):
	if PlayerInput.get_move_axes() != Vector3.ZERO:
		_switch_state("WalkState")
		return
	elif not _is_grounded():
		_switch_state("FallState")
		return
	elif PlayerInput.get_is_action():
#		TODO: Very bad design. Waiting for the Interaction System...
		var maybe_car : Spatial = get_tree().root.get_node_or_null("Spatial/Car")
		if maybe_car != null:
			var distance := maybe_car.global_transform.origin.distance_to(get_parent().get_parent().global_transform.origin)
			if distance < 2:
				get_parent().get_node("DriveState").vehicle = maybe_car
				_switch_state("DriveState")
				return
		
	_process_gravity(delta)
	_process_jump()
	_process_brake(delta)
	_process_movement_on_ground(Vector3.ZERO, delta)
	
	_idle_walk_blend_anim.value = move_toward(_idle_walk_blend_anim.value, 0, delta * 4)
	_falling_blend_anim.value = move_toward(_falling_blend_anim.value, 0, delta * 7)


func _on_exit():
	pass

