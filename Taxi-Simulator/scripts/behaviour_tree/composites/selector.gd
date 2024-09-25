extends BTComposite
class_name BTSelector


# Overridden
func _process_tick_result(tick_result : int) -> int:
	var result : int = tick_result
	match tick_result:
		TickResult.SUCCESS:
			_set_behaviour_node_index_to_first()
		TickResult.FAILURE:
			_set_behaviour_node_index_to_next()
			if !_is_first_behaviour_node_index():
				result = TickResult.RUNNING
		TickResult.RUNNING:
			pass
	return result

