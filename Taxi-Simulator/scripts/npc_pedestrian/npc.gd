extends RiderCharacter
class_name NPC

const MIN_SPEED_APPROX : float = 0.001

onready var _animator : Animator = $WomanCharacter
onready var _idle_anim_transition := BooleanAnimatorProperty.new(_animator, "idle")
onready var _walk_anim_transition := BooleanAnimatorProperty.new(_animator, "walk")
var _blackboard_vehicle_property : BTBlackboardProperty


func move_to(target : Vector3, delta : float, use_navigation : bool = true) -> bool:
	if has_vehicle() && get_is_driver():
		return $DriveMovementController.move_to(target, delta, use_navigation)
	return $MovementController.move_to(target, delta, use_navigation)


func rotate_to(target : Vector3, delta : float, best_angle : float = 10.0) -> bool:
	if has_vehicle():
		push_warning("The actor is in the vehicle %s" % get_vehicle())
		return false
	var normal_target := Vector3(target.x, global_transform.origin.y, target.z)
	var direction := global_transform.origin.direction_to(normal_target)
	$MovementController.rotate_to_direction(direction, delta)
	var angle := global_transform.basis.z.angle_to(-direction)
	return angle <= best_angle


# Overridden
func get_vehicle() -> Vehicle:
	return $DriveMovementController.vehicle


# overridden
func get_into_vehicle_instantly(vehicle : Vehicle, seat_key : String):
	$CollisionShape.disabled = true
	$NavigationAgent.roadway_name = "CarRoadway"
	$DriveMovementController.vehicle = vehicle
	$MovementController.set_physics_process(false)
	$BTBehaviourTree.active = get_is_driver()
	_blackboard_vehicle_property.value = vehicle


# overridden
func get_out_of_vehicle_instantly():
	$CollisionShape.disabled = true
	$NavigationAgent.roadway_name = "PedestrianRoadway"
	$DriveMovementController.vehicle = null
	$MovementController.set_physics_process(true)
	$BTBehaviourTree.active = true
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

