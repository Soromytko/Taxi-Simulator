extends RiderCharacter
class_name NPC

const MIN_SPEED_APPROX : float = 0.001

onready var _animator : Animator = $WomanCharacter
onready var _idle_anim_transition := BooleanAnimatorProperty.new(_animator, "idle")
onready var _walk_anim_transition := BooleanAnimatorProperty.new(_animator, "walk")
var _blackboard_vehicle_property : BTBlackboardProperty


func move_to(target : Vector3, delta : float) -> bool:
	if has_vehicle():
		return $DriveMovementController.move_to(target, delta)
	return $MovementController.move_to(target, delta)


# Overridden
func get_vehicle() -> Vehicle:
	return $DriveMovementController.vehicle


# overridden
func get_into_vehicle_instantly(vehicle : Vehicle, _vehicle_seat_type : int):
	$CollisionShape.disabled = true
	$NavigationAgent.roadway_name = "CarRoadway"
	$DriveMovementController.vehicle = vehicle
	_blackboard_vehicle_property.value = vehicle


# overridden
func get_out_of_vehicle_instantly():
	$CollisionShape.disabled = true
	$NavigationAgent.roadway_name = "PedestrianRoadway"
	$DriveMovementController.vehicle = null
	_blackboard_vehicle_property.value = null


func _ready():
	_animator.start_playback("idle-loop")
	_catch_taxi_if_random()
	_blackboard_vehicle_property = $BTBehaviourTree/BTBlackboard.get_property("vehicle_actor")
	$MovementController.collision_shape = $CollisionShape
	$MovementController.navigation_agent = $NavigationAgent
	$DriveMovementController.navigation_agent = $NavigationAgent


func _enter_tree():
	$MovementController.connect("moved", self, "_on_moved")


func _exit_tree():
	$MovementController.disconnect("moved", self, "_on_moved")


func _is_reached_target(target : Vector3):
	var distance_to_target := global_transform.origin.distance_to(target)
	return distance_to_target < $CollisionShape.shape.radius


func _on_moved(velocity : Vector3):
	var horizontal_speed := _get_horizontal_speed(velocity)
	var is_moved := horizontal_speed > MIN_SPEED_APPROX
	_idle_anim_transition.value = !is_moved
	_walk_anim_transition.value = is_moved


func _get_horizontal_speed(velocity : Vector3) -> float:
	return Vector3(velocity.x, 0.0, velocity.z).length()


func _catch_taxi_if_random():
	var rng := TimedRNG.new()
	if rng.randi_range(1, 10) <= 3:
		$BTBehaviourTree/BTBlackboard.get_property("is_need_taxi").value = true

