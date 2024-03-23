extends "./human_player_state.gd"


func _on_enter():
	pass


func _on_physics_update(delta : float):
	var input : Vector3 = class_player_input.get_move_axes()
	if input == Vector3.ZERO:
		_switch_state("IdleState")
		return
	_player.move_by_camera_view(input, delta)


func _on_exit():
	pass
