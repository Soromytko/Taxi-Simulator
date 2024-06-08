extends "./player_state.gd"


func _on_enter():
	._on_enter()
	pass


func _on_physics_update(delta : float):
#	if !_player_movement_controller.is_grounded():
#		_player_movement_controller.apply_gravity(delta)
	
	if class_player_input.get_move_axes() != Vector3.ZERO:
		_switch_state("WalkState")
	
	_idle_walk_blend_value = move_toward(_idle_walk_blend_value, 0, delta * 4)
	_animator.set_blend_value("idle_walk", _idle_walk_blend_value)

func _on_exit():
	pass
