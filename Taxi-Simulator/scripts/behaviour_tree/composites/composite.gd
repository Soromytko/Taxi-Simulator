extends BTBehaviourNode
class_name BTComposite

onready var _behaviour_nodes : Array = _find_behaviour_nodes()
onready var _behaviour_node_index : int = _init_behaviour_node_index()
var _last_tick_result : int = TickResult.FAILURE


# Overridden
func on_tick(delta : float, actor : Node, blackboard : BTBlackboard) -> int:
	var behaviour_node := _get_behaviour_node()
	if behaviour_node:
		_last_tick_result = behaviour_node.on_tick(delta, actor, blackboard)
	return _last_tick_result


func _find_behaviour_nodes() -> Array:
	var result : Array = []
	for child in get_children():
		if child is BTBehaviourNode:
			result.append(child)
	return result


func _get_behaviour_node() -> BTBehaviourNode:
	push_warning("Override me!")
	return null


func _init_behaviour_node_index() -> int:
	 return 0 if _behaviour_nodes.size() > 0 else -1 


func _get_current_behaviour_node() -> BTBehaviourNode:
	if _behaviour_node_index >= 0:
		return _behaviour_nodes[_behaviour_node_index]
	return null


func _get_next_behaviour_node() -> BTBehaviourNode:
	if _behaviour_nodes.size() == 0:
		return null
	if _behaviour_node_index + 1 < _behaviour_nodes.size():
		_behaviour_node_index += 1
	else:
		_behaviour_node_index = 0
	return _behaviour_nodes[_behaviour_node_index]


func _get_first_behaviour_node() -> BTBehaviourNode:
	_behaviour_node_index = 0
	return _get_current_behaviour_node()
	
