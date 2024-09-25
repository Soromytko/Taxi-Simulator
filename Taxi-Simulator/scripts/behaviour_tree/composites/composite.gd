extends BTBehaviourNode
class_name BTComposite

onready var _behaviour_nodes : Array = _find_behaviour_nodes()
onready var _behaviour_node_index : int = _init_behaviour_node_index()


# Overridden
func set_blackboard(value : BTBlackboard):
	.set_blackboard(value)
	for behaviour_node in _behaviour_nodes:
		behaviour_node.set_blackboard(value)


# Overridden
func on_tick(delta : float) -> int:
	if !_check_decorators(delta):
		return TickResult.FAILURE
	var behaviour_node := _get_current_behaviour_node()
	if behaviour_node:
		var tick_result := behaviour_node.on_tick(delta)
		return _process_tick_result(tick_result)
	return TickResult.FAILURE


func _find_behaviour_nodes() -> Array:
	var result : Array = []
	for child in get_children():
		if child is BTBehaviourNode:
			result.append(child)
	return result


func _process_tick_result(_tick_result : int) -> int:
	push_warning("Override me!")
	return -1


func _init_behaviour_node_index() -> int:
	 return 0 if _behaviour_nodes.size() > 0 else -1 


func _get_current_behaviour_node() -> BTBehaviourNode:
	if _behaviour_node_index >= 0 && _behaviour_node_index < _behaviour_nodes.size():
		return _behaviour_nodes[_behaviour_node_index]
	return null


func _set_behaviour_node_index_to_next():
	if _behaviour_nodes.size() == 0:
		_behaviour_node_index = -1
	elif _behaviour_node_index + 1 < _behaviour_nodes.size():
		_behaviour_node_index += 1
	else:
		_behaviour_node_index = 0


func _set_behaviour_node_index_to_first():
	if _behaviour_nodes.size() == 0:
		_behaviour_node_index = -1
	else:
		_behaviour_node_index = 0


func _is_first_behaviour_node_index() -> bool:
	return _behaviour_node_index == 0


func _check_decorators(delta : float) -> bool:
	for decorator in _decorators:
		if !decorator.on_check(delta):
			return false
	return true

