extends "./player_state.gd"


func _on_enter():
	._on_enter()


func _on_physics_update(delta : float):
	var input : Vector3 = class_player_input.get_move_axes()
	if input == Vector3.ZERO:
		_switch_state("IdleState")
		return
	elif not _is_grounded():
		_switch_state("FallState")
		return
	
	_process_gravity(delta)
	_process_jump()
	_process_movement_on_ground(input, delta)
	
	_idle_walk_blend_anim.value = move_toward(_idle_walk_blend_anim.value, 1, delta * 4)
	_falling_blend_anim.value = move_toward(_falling_blend_anim.value, 0, delta * 7)


func _on_exit():
	pass
