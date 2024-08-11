extends "./movement_player_state.gd"


func _on_enter():
	pass


func _on_physics_update(delta : float):
	_process_gravity(delta)


func _on_exit():
	pass
