extends CharacterMovementController
class_name NPCMovementController

var navigation_agent : RWNavigationAgent
var collision_shape : CollisionShape
var _movement_direction : Vector3


func move_and_rotate(direction : Vector3, delta : float):
	rotate_to_direction(direction, delta)
	move_in_direction(_get_forward(), delta)


func move_to(target : Vector3, _delta : float, use_navigation : bool = true):
	_movement_direction = Vector3.ZERO
	if _is_reached_target(target):
		return true
	if use_navigation:
		_move_to_with_navigation(target)
	else:
		_move_to_without_navigation(target)
	return false


func _move_to_with_navigation(target : Vector3):
	navigation_agent.target_position = target
	var next_position := navigation_agent.get_next_path_position()
	var direction := global_transform.origin.direction_to(next_position)
	_movement_direction = direction


func _move_to_without_navigation(target : Vector3):
	_movement_direction = global_transform.origin.direction_to(target)


func _is_reached_target(target : Vector3):
	var distance_to_target := global_transform.origin.distance_to(target)
	return distance_to_target < collision_shape.shape.radius


func _physics_process(delta : float):
	apply_gravity(delta)
	if _movement_direction != Vector3.ZERO:
		# The "move_and_rotate" method applies velocity
		move_and_rotate(_movement_direction, delta)
		_movement_direction = Vector3.ZERO
	else:
		brake(delta)
		apply_velocity()

