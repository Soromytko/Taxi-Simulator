extends BTComposite
class_name BTSelector


# Overridden
func _get_behaviour_node() -> BTBehaviourNode:
	var result : BTBehaviourNode = null
	match _last_tick_result:
		TickResult.SUCCESS:
			result = _get_first_behaviour_node()
		TickResult.FAILURE:
			result = _get_next_behaviour_node()
		TickResult.RUNNING:
			result = _get_current_behaviour_node()
	return result


# Overridden
func _init_tick_result() -> int:
	return TickResult.SUCCESS

