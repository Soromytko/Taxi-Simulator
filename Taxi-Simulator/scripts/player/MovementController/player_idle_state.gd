extends "./player_state.gd"


func _on_enter():
	._on_enter()


func _on_physics_update(delta : float):
	if class_player_input.get_move_axes() != Vector3.ZERO:
		_switch_state("WalkState")
		return
	elif not _is_grounded():
		_switch_state("FallState")
		return
		
	_process_gravity(delta)
	_process_jump()
	_process_brake(delta)
	_process_movement_on_ground(Vector3.ZERO, delta)
	
	_idle_walk_blend_value = move_toward(_idle_walk_blend_value, 0, delta * 4)
	_falling_blend_value = move_toward(_falling_blend_value, 0, delta * 7)
	_animator.set_blend_value("idle_walk", _idle_walk_blend_value)
	_animator.set_blend_value("falling", _falling_blend_value)

func _on_exit():
	pass

