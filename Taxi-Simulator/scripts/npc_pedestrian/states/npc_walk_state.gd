extends "./npc_state.gd"

onready var _walk_anim_bool := BooleanAnimatorProperty.new(_animator, "idle_walk")


func _on_enter():
	_walk_anim_bool.value = true


func _on_physics_update(delta : float):
	if _roadway_follower.current_waypoint == null:
		_switch_state(States.IDLE)
		return
	_move(delta)
	_roadway_follower.set_next_waypoint_if_reached()


func _move(delta : float):
	_movement_controller.move(_roadway_follower._get_direction_to_current_waypoint().normalized(), delta)


func _on_exit():
	_walk_anim_bool.value = false

