extends "./npc_state.gd"

onready var _idle_anim_bool := BooleanAnimatorProperty.new(_animator, "walk_idle")


func _on_enter():
	_idle_anim_bool.value = true


func _on_physics_update(delta : float):
	if _roadway_follower.current_waypoint != null:
		_switch_state(States.WALK)


func _on_exit():
	_idle_anim_bool.value = false
