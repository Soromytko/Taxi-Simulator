extends KinematicBody
class_name NPC

onready var _movement_controller : NPCMovementController = $MovementController
onready var _animator : Animator = $WomanCharacter
var is_into_vehicle : bool setget , get_is_into_vehicle


func get_is_into_vehicle() -> bool:
	return get_parent() is VehicleBody


func get_into_vehicle_instantly(vehicle : Vehicle, vehicle_seat_type : int):
	$CollisionShape.disabled = true
	$StateMachine/DriveState.vehicle = vehicle
	$StateMachine.switch_state("DriveState")


func get_out_of_vehicle_instantly():
	$CollisionShape.disabled = true
	$StateMachine/DriveState.vehicle_body = null
	$StateMachine.switch_state("IdleState")


func _ready():
	_animator.start_playback("idle-loop")

