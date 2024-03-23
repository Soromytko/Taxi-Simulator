extends "../player_controller.gd"


var move_speed : float = 5
var rotation_speed : float = 3

var _move_speed_multiplier = 100

var _velocity : Vector3


func move(var direction : Vector3, var delta : float = 1):
	if kinematic_body == null:
		return
	_rotate_to_direction(direction, delta)
	var speed : float = move_speed * _move_speed_multiplier * delta
	_velocity.x = direction.x * speed
	_velocity.z = direction.z * speed
	_velocity = kinematic_body.move_and_slide(_velocity, Vector3.UP)


func _rotate_to_direction(direction : Vector3, delta : float = 1):
	if kinematic_body == null:
		return
	var rotation_target = atan2(-direction.x, -direction.z)
	kinematic_body.rotation.y = lerp_angle(kinematic_body.rotation.y, rotation_target, rotation_speed * delta)
