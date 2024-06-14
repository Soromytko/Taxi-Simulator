extends "res://addons/movement_controller/scripts/movement_controller.gd"

export(Resource) var movement_model_resource : Resource
var movement_model : HumanMovementModel setget set_movement_model, get_movement_model


func _ready():
	movement_model = movement_model_resource


func set_movement_model(value : HumanMovementModel):
	movement_model = value


func get_movement_model() -> HumanMovementModel:
	return movement_model


func jump():
	accelerate_vertical(movement_model.jump_force, movement_model.max_vertical_speed)


func apply_gravity(delta : float):
	accelerate_vertical(-movement_model.gravity_force * delta, movement_model.max_vertical_speed)


func move_in_direction(direction : Vector3, delta : float):
	accelerate_horizontal(direction, movement_model.acceleration * delta, movement_model.max_horizontal_speed)
	apply_velocity()


func brake(delta : float):
	decelerate_horizontal(movement_model.deceleration * delta)


func rotate_to_direction(direction : Vector3, delta : float):
	var rotation_target = atan2(-direction.x, -direction.z)
	kinematic_body.rotation.y = lerp_angle(kinematic_body.rotation.y, rotation_target, movement_model.rotation_speed * delta)


