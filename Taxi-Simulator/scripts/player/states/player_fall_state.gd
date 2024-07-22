extends "./movement_player_state.gd"


func _on_physics_update(delta : float):
	if _is_grounded():
		_switch_state("WalkState")
		return
	var input : Vector3 = PlayerInput.get_move_axes()
	
	_process_gravity(delta)
	_process_jump()
#	_process_brake(delta / 100)
	_process_movement_in_fall(input, delta)
#	_process_forward_movement(input, delta / 5)
#	_movement_controller.fade_horizontal_velocity(delta)
	
	_falling_blend_anim.value = move_toward(_falling_blend_anim.value, 1, delta * 7)


func _on_exit():
	pass
