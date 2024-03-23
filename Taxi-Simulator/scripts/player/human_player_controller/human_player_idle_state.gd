extends "./human_player_state.gd"


func _on_enter():
	pass


func _on_physics_update(_delta : float):
	if !player_movement_controller.is_grounded():
		player_movement_controller.apply_gravity(delta)
	
	if class_player_input.get_move_axes() != Vector3.ZERO:
		_switch_state("WalkState")


func _on_exit():
	pass
