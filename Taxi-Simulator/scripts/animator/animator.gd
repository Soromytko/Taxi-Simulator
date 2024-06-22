extends Spatial
class_name Animator

export var animation_tree_node_path : NodePath

onready var _animation_tree : AnimationTree = get_node(animation_tree_node_path)


func set_blend_value(blend_name : String, value : float):
	var property := _get_blend_property(blend_name)
	_animation_tree.set(property, value)


func set_condition(condition_name : String, value : float):
	var property := _get_condition_property(condition_name)
	_animation_tree.set(property, value)


func get_condition(condition_name : String) -> bool:
	var property := _get_condition_property(condition_name)
	return _animation_tree.get(property)


func get_blend_value(blend_name : String) -> float:
	var property := _get_blend_property(blend_name)
	return _animation_tree.get(property)


func start_playback(animation_name : String):
	var playback : AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")
	if playback == null:
		return
	playback.start(animation_name)


func _get_property(property_name : String) -> String:
	return "parameters/%s" % property_name


func _get_blend_property(property_name : String) -> String:
	return "%s/blend_amount" % _get_property(property_name)


func _get_condition_property(property_name : String) -> String:
	return "%s/%s" % [_get_property("conditions"), property_name]
