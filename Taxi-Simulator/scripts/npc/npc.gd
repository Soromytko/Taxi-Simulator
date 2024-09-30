extends RiderCharacter
class_name NPC

const MIN_SPEED_APPROX : float = 0.001

var is_taxi_required : bool setget , get_is_taxi_required
#var destination : Vector3 setget , get_destination
onready var _animator : Animator = $WomanCharacter
onready var _idle_anim_transition := BooleanAnimatorProperty.new(_animator, "idle")
onready var _walk_anim_transition := BooleanAnimatorProperty.new(_animator, "walk")
var _blackboard_vehicle_property : BTBlackboardProperty
var _is_taxi_required : bool


func get_is_taxi_required() -> bool:
	return _is_taxi_required


func set_is_taxi_required(value : bool):
	if _is_taxi_required != value:
		_is_taxi_required = value
		$LocationMarkerSprite.visible = value
		var v = true if value else null
		$BTBehaviourTree/BTBlackboard.get_property("is_taxi_required").value = v


func get_destination() -> Vector3:
	var property = $BTBehaviourTree/BTBlackboard.get_property("target_waypoint")
	return property.value.global_transform.origin


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
	if vehicle is TaxiCar:
		$BTBehaviourTree.active = true
		var mesh_instance := MeshInstance.new()
		get_tree().root.get_child(0).add_child(mesh_instance)
		var cubeMesh := CubeMesh.new()
		cubeMesh.size = Vector3(1, 100, 1)
		mesh_instance.mesh = cubeMesh
		mesh_instance.global_transform.origin = get_destination()


# overridden
func get_out_of_vehicle_instantly():
	$CollisionShape.disabled = false
	$NavigationAgent.roadway_name = "PedestrianRoadway"
	$DriveMovementController.vehicle = null
	$MovementController.set_physics_process(true)
	$BTBehaviourTree.active = true
	_blackboard_vehicle_property.value = null
	
	set_is_taxi_required(false)
	return
	_is_taxi_required = false
	$LocationMarkerSprite.visible = false
	$BTBehaviourTree/BTBlackboard.get_property("is_taxi_required").value = null


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
		set_is_taxi_required(true)

