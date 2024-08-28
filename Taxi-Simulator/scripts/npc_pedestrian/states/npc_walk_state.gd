extends "./npc_movement_state.gd"

onready var _walk_anim_transition := BooleanAnimatorProperty.new(_animator, "walk")


func _on_enter():
	_walk_anim_transition.value = true
	_init_navigation_agent()
	_enable_interactable()


func _on_physics_update(delta : float):
	_process_gravity(delta)
	var next_position := _navigation_agent.get_next_path_position()
	if next_position == _navigation_agent.global_transform.origin:
		set_random_target_position()
		return
	_move(next_position, delta)


func _move(target_position : Vector3, delta : float):
	var direction := (target_position - _navigation_agent.global_transform.origin).normalized()
	_movement_controller.move(direction, delta)


func _on_exit():
	_walk_anim_transition.value = false
	_disable_interactable()

