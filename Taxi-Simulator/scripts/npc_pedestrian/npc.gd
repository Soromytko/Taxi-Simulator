extends RiderCharacter
class_name NPC

onready var _movement_controller : NPCMovementController = $MovementController
onready var _animator : Animator = $WomanCharacter


# overridden
func get_into_vehicle_instantly(vehicle : Vehicle, _vehicle_seat_type : int):
	$CollisionShape.disabled = true
	$StateMachine/DriveState.vehicle = vehicle
	$StateMachine.switch_state("DriveState")


# overridden
func get_out_of_vehicle_instantly():
	$CollisionShape.disabled = true
	$StateMachine/DriveState.vehicle_body = null
	$StateMachine.switch_state("IdleState")


func _ready():
	_animator.start_playback("idle-loop")
	_catch_taxi_if_random()


func _catch_taxi_if_random():
	var rng := TimedRNG.new()
	if rng.randi_range(1, 10) <= 3:
		$StateMachine.switch_state("CatchTaxiState")
