extends Spatial

signal moved(velocity)

export(NodePath) var kinematic_body_node_path

var kinematic_body : KinematicBody setget set_kinematic_body, get_kinematic_body

var velocity : Vector3 = Vector3.ZERO


func _ready():
	kinematic_body = get_node(kinematic_body_node_path)


func set_kinematic_body(value):
	kinematic_body = value


func get_kinematic_body() -> KinematicBody:
	return kinematic_body


func is_grounded() -> bool:
	return kinematic_body.is_on_floor()


func accelerate_horizontal(direction : Vector3, acceleration : float, max_speed : float):
	var horizontal_velocity := _get_horizontal_velocity()
	if horizontal_velocity.length() < max_speed || true:
		horizontal_velocity += direction * acceleration
		if horizontal_velocity.length() > max_speed:
			horizontal_velocity = horizontal_velocity.normalized() * max_speed
	_set_horizontal_velocity(horizontal_velocity)


func decelerate_horizontal(decceleration : float):
	var horizontal_velocity := _get_horizontal_velocity()
	horizontal_velocity = horizontal_velocity.move_toward(Vector3.ZERO, decceleration)
	_set_horizontal_velocity(horizontal_velocity)


func accelerate_vertical(acceleration : float, max_speed : float):
	velocity.y = min(velocity.y + acceleration, max_speed) if acceleration > 0 \
				else max(velocity.y + acceleration, -max_speed)


func apply_velocity():
	velocity = kinematic_body.move_and_slide(velocity, Vector3.UP)
	emit_signal("moved", velocity)


func fade_horizontal_velocity(damping : float, max_speed : float):
	var horizontal_velocity := _get_horizontal_velocity()
	if horizontal_velocity.length() > max_speed:
		horizontal_velocity = horizontal_velocity.move_toward(horizontal_velocity.normalized() * max_speed, damping)
	_set_horizontal_velocity(horizontal_velocity)


func _get_horizontal_velocity() -> Vector3:
	return Vector3(velocity.x, 0, velocity.z)


func _set_horizontal_velocity(value : Vector3):
	velocity = Vector3(value.x, velocity.y, value.z)
