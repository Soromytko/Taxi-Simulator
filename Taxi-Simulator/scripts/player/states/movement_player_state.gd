extends "./player_state.gd"

export(NodePath) var movement_controller_node_path
export(Resource) var movement_model_resource

onready var movement_controller : PlayerMovementController = get_node(movement_controller_node_path) 
onready var movement_model : CharacterMovementModel = movement_model_resource
onready var _idle_walk_blend_anim := BlendAnimatorProperty.new(_animator, "idle_walk")
onready var _falling_blend_anim := BlendAnimatorProperty.new(_animator, "falling")


func _on_enter():
	_idle_walk_blend_anim.update()
	_falling_blend_anim.update()
	movement_controller.movement_model = movement_model


func _is_grounded() -> bool:
	return movement_controller.is_grounded()


func _process_movement_on_ground(input : Vector3, delta : float):
	if input == Vector3.ZERO:
		movement_controller.apply_velocity()
	else:
		movement_controller.move_by_camera_view(input, delta)


func _process_movement_in_fall(input : Vector3, delta : float):
	if input == Vector3.ZERO:
		movement_controller.apply_velocity()
	else:
		movement_controller.move_in_direction_and_rotate(input, delta)


func _process_brake(delta : float):
	movement_controller.brake(delta)


func _process_gravity(delta : float):
	movement_controller.apply_gravity(delta)


func _process_jump():
	if PlayerInput.get_is_jump():
		if movement_controller.is_grounded():
			movement_controller.jump()
