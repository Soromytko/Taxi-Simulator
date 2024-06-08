extends "./player_state.gd"


func _on_enter():
	._on_enter()


func _on_physics_update(delta : float):
	var input : Vector3 = class_player_input.get_move_axes()
	if input == Vector3.ZERO:
		_switch_state("IdleState")
		return
	_movement_controller.move_by_camera_view(input, delta * 0.7)
	_idle_walk_blend_value = move_toward(_idle_walk_blend_value, 1, delta * 4)
	_animator.set_blend_value("idle_walk", _idle_walk_blend_value)


func _on_exit():
	pass
