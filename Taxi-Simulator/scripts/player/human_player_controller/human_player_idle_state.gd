extends "./human_player_state.gd"


func _on_enter():
	pass


func _on_update(_delta):
	if class_player_input.get_move_axes() != Vector3.ZERO:
		_switch_state("WalkState")
	


func _on_exit():
	pass
