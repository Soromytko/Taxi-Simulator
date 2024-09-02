tool
extends RiderCharacter

export var radius : float = 1.0 setget set_radius, get_radius
export var height : float = 2.0 setget set_height, get_height


# Overridden
func get_vehicle() -> Vehicle:
	return $StateMachine/DriveState.vehicle


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


# overridden
func get_into_vehicle_instantly(vehicle : Vehicle, vehicle_seat_type : int):
	$CollisionShape.disabled = true
	$StateMachine/DriveState.vehicle = vehicle
	$StateMachine.switch_state("DriveState")


# overridden
func get_out_of_vehicle_instantly():
	$CollisionShape.disabled = false
	$StateMachine/DriveState.vehicle = null
	$StateMachine.switch_state("IdleState")
