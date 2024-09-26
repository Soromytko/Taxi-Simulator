extends Node
class_name BTBehaviourTree

enum TickType {
	PROCESS,
	PHYSICS_PROCESS,
}

export var active : bool = true setget set_active, get_active
export(int, "Process", "Physics process") var _tick_type : int
export var _actor_node_path : NodePath
export var _blackboard_node_path : NodePath
onready var _blackboard : BTBlackboard = get_node_or_null(_blackboard_node_path)
onready var _actor : Spatial = get_node_or_null(_actor_node_path)
onready var _behaviour_root : BTBehaviourNode = _find_behaviour_root()
var _active : bool = true


func set_active(value : bool):
	if _active != value:
		_active = value
		_update_activity()


func get_active() -> bool:
	return _active


func _ready():
	_init_blackboard()
	# According to the documentation,
	# update the activity only after it is ready.
	_update_activity()


func _update_activity():
	set_process(_active && _tick_type == TickType.PROCESS)
	set_physics_process(_active && _tick_type == TickType.PHYSICS_PROCESS)


func _find_behaviour_root() -> BTBehaviourNode:
	for child in get_children():
		if child is BTBehaviourNode:
			return child
	return null


func _init_blackboard():
	var actor_property := _blackboard.get_property(BTBehaviourNode.ACTOR_PROPERTY_NAME)
	actor_property.value = _actor
	_behaviour_root.set_blackboard(_blackboard)


func _process(delta : float):
	_process_tick(delta)


func _physics_process(delta : float):
	_process_tick(delta)


func _process_tick(delta : float):
	if _behaviour_root:
		_behaviour_root.on_tick(delta)

