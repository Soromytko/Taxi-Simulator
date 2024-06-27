extends "../../human_movement_controller.gd"
class_name NPCMovementController


func move(direction : Vector3, delta : float):
	rotate_to_direction(direction, delta)
	move_in_direction(_get_forward(), delta)

