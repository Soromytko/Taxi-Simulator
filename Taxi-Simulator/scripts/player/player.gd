tool
extends KinematicBody

export var radius : float = 1.0 setget set_radius, get_radius
export var height : float = 2.0 setget set_height, get_height


func set_radius(value):
	radius = value
	_update_collision_shape_data()


func get_radius():
	return radius


func set_height(value):
	height = value
	_update_collision_shape_data()


func get_height():
	return height


func _update_collision_shape_data():
	var collision_shape : CollisionShape = get_node_or_null("CollisionShape")
	if collision_shape == null:
		return
	collision_shape.shape.radius = radius
	collision_shape.shape.height = height
	collision_shape.transform.origin.y = height / 2.0 + 1.0 + (radius - 1)
