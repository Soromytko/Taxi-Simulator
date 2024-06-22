extends "./path_follower.gd"

export var steer_speed = 1.0
var mesh_instance : MeshInstance

func _ready():
	_init_current_waypoint()
	mesh_instance = MeshInstance.new()
	add_child(mesh_instance)
	mesh_instance.mesh = CubeMesh.new()
	mesh_instance.global_transform = mesh_instance.global_transform.scaled(Vector3.ONE * 0.2)


func _physics_process(delta):
	if _current_waypoint == null:
		return
	_drive(delta)
	if _is_reach_current_roadpoint():
		_current_waypoint = _get_next_waypoint()


func _get_next_waypoint():
	return _current_waypoint.next_waypoint


func _drive(delta : float):
	mesh_instance.global_transform.origin = _current_waypoint.global_transform.origin
	var target_steering = _calculate_steering()
	steering = move_toward(steering, target_steering, delta * steer_speed)
	engine_force = 4
	brake = 0
#	print("NO BRAKE")
	print(linear_velocity.length())
	if abs(steering) > deg2rad(30):
#		engine_force /= 2
		brake = engine_force * 10
#		print("BRAKE ", brake)
