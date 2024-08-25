extends "./npc_movement_state.gd"

onready var _idle_anim_transition := BooleanAnimatorProperty.new(_animator, "idle")


func _on_enter():
	_idle_anim_transition.value = true
	_init_roadway_follower()
	_enable_interactable()
	set_random_target_position()


func _on_physics_update(delta : float):
	_process_gravity(delta)
	if _roadway_follower.get_next_path_position() != _roadway_follower.global_transform.origin:
		_switch_state(States.WALK)
	else:
		set_random_target_position()


func _on_exit():
	_idle_anim_transition.value = false
	_disable_interactable()

