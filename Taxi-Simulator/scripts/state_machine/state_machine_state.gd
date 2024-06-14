extends Node
class_name StateMachineState 

signal transitioned


func _switch_state(state_name : String):
	emit_signal("transitioned", state_name)


func _on_enter():
	pass


func _on_update(_delta : float):
	pass

	
func _on_physics_update(_delta : float):
	pass


func _on_exit():
	pass
