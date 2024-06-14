extends "./player_state.gd"


func _on_enter():
	._on_enter()


func _on_physics_update(delta : float):
	if _is_grounded():
		_switch_state("WalkState")
		return
	var input : Vector3 = class_player_input.get_move_axes()
	
	_process_gravity(delta)
	_process_jump()
#	_process_brake(delta / 100)
	_process_movement_in_fall(input, delta)
#	_process_forward_movement(input, delta / 5)
#	_movement_controller.fade_horizontal_velocity(delta)
	
	_falling_blend_value = move_toward(_falling_blend_value, 1, delta * 7)
	_animator.set_blend_value("falling", _falling_blend_value)


func _on_exit():
	pass
