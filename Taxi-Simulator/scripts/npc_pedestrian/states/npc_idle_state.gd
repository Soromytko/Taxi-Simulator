extends "./npc_movement_state.gd"

onready var _idle_anim_transition := BooleanAnimatorProperty.new(_animator, "idle")


func _on_enter():
	_idle_anim_transition.value = true
	_init_navigation_agent()
	_enable_interactable()
	set_random_target_position()


func _on_physics_update(delta : float):
	_process_gravity(delta)
	if _navigation_agent.get_next_path_position() != _navigation_agent.global_transform.origin:
		_switch_state(States.WALK)
	else:
		set_random_target_position()


func _on_exit():
	_idle_anim_transition.value = false
	_disable_interactable()

