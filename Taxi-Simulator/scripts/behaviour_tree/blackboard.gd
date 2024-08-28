extends Node
class_name BTBlackboard

export var _property_names : Array = ["actor"]
# Do not export Dictionary
# https://www.reddit.com/r/godot/comments/rythz1/dictionary_becomes_shared_between_instances_when/
var _properties : Dictionary = {}


func _enter_tree():
	for property_name in _property_names:
		if !has_property(property_name):
			var property := create_property(property_name)
			add_property(property)


func get_property_names() -> Array:
	return _properties.keys()


func has_property(property_name : String):
	return _properties.has(property_name)


func get_property(property_name : String) -> BTBlackboardProperty:
	if _properties.has(property_name):
		return _properties[property_name] as BTBlackboardProperty
	return null


func create_property(property_name : String) -> BTBlackboardProperty:
	return BTBlackboardProperty.new(property_name)


func add_property(property : BTBlackboardProperty):
	var property_name := property.name
	if _properties.has(property_name):
		push_warning("A property named \"%s\" already exists" % property_name)
		return
	_properties[property_name] = property


func remove_property(property_name : String):
	if !_properties.erase(property_name):
		push_warning("A property named \"%s\" does not exist" % property_name)

