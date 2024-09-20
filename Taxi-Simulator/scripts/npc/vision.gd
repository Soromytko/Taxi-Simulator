extends Area

export var _blackboard_node_path : NodePath
export var _blackboard_property_name : String = "visible_taxi"
onready var _blackboard : BTBlackboard = get_node(_blackboard_node_path)
onready var _blackboard_property : BTBlackboardProperty = _blackboard.get_property(_blackboard_property_name)


func _enter_tree():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")


func _exit_tree():
	disconnect("body_entered", self, "_on_body_entered")
	disconnect("body_exited", self, "_on_body_exited")


func _on_body_entered(body : Node):
	if body is TaxiCar && !_blackboard_property.value:
		_blackboard_property.value = body


func _on_body_exited(body : Node):
	if body is TaxiCar && _blackboard_property.value:
		_blackboard_property.value = null


