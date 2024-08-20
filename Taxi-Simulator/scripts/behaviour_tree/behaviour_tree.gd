extends Node
class_name BTBehaviourTree

enum TickType {
	PROCESS,
	PHYSICS_PROCESS,
}

export(int, "PROCESS", "PHYSICS_PROCESS") var _tick_type : int
export var _blackboard_node_path : NodePath
export var _actor_node_path : NodePath
onready var _actor : Node = get_node_or_null(_actor_node_path)
onready var _blackboard : BTBlackboard = get_node_or_null(_blackboard_node_path)
onready var _behaviour_root : BTBehaviourNode = _find_behaviour_root()


func _ready():
	set_process(_tick_type == TickType.PROCESS)
	set_physics_process(_tick_type == TickType.PHYSICS_PROCESS)


func _find_behaviour_root() -> BTBehaviourNode:
	for child in get_children():
		if child is BTBehaviourNode:
			return child
	return null


func _process(delta : float):
	_process_tick(delta)


func _physics_process(delta : float):
	_process_tick(delta)


func _process_tick(delta : float):
	if _behaviour_root:
		_behaviour_root.on_tick(delta, _actor, _blackboard)

