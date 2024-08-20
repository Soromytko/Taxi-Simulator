extends Node
class_name BTBehaviourNode

enum TickResult {
	SUCCESS,
	FAILURE,
	RUNNING,
}


func on_tick(delta : float, actor : Node, blackboard : BTBlackboard) -> int:
	push_warning("Override me! %f, %s, %s" % [delta, actor, blackboard])
	return TickResult.FAILURE
