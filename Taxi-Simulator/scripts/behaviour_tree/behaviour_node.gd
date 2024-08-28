extends BTNodeWithBlackboard
class_name BTBehaviourNode

enum TickResult {
	SUCCESS,
	FAILURE,
	RUNNING,
}

var _decorators : Array


# Overridden
func set_blackboard(value : BTBlackboard):
	.set_blackboard(value)
	for decorator in _decorators:
		decorator.set_blackboard(value)


func on_tick(_delta : float) -> int:
	push_warning("Override me!")
	return TickResult.FAILURE


func _enter_tree():
	_find_decorators()


func _find_decorators():
	for child in get_children():
		if child is BTDecorator:
			_decorators.append(child)

