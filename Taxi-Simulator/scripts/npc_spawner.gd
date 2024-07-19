extends Spatial
class_name NPCSpawner

export var _observer_node_path : NodePath
export var _roadway_node_path : NodePath
export var _min_distance : float = 1.0
export var _max_distance : float = 20.0
export var _instance_count : int = 3
export(Array, PackedScene) var _npc_packed_scenes : Array
onready var _observer : Spatial = get_node(_observer_node_path)
onready var _roadway : Roadway = get_node(_roadway_node_path)
onready var _rng := TimedRNG.new()
var _spawned_npcs : Array = []


func _ready():
	_spawn()


func _spawn():
	var suitable_waypoints := _get_suitable_waypoints()
	for i in _instance_count:
		var rand_index := _get_rand_array_index(_rng, _npc_packed_scenes)
		var waypoint := _pull_rand_waypoint(suitable_waypoints)
		var npc := _spawn_npc(rand_index, waypoint)
		_spawned_npcs.append(npc)


func _spawn_npc(index : int, waypoint : Waypoint) -> PhysicsBody:
	var npc : PhysicsBody = _npc_packed_scenes[index].instance()
	call_deferred("_on_spawn_npc_deferred", npc, waypoint)
	return npc


func _on_spawn_npc_deferred(npc : PhysicsBody, waypoint : Waypoint):
	add_child(npc)
	var npc_position := waypoint.global_transform.origin
	var npc_direction := _determine_waypoint_direction(waypoint)
	npc.global_transform.origin = npc_position
	npc.global_transform = npc.global_transform.looking_at(npc_position + npc_direction, Vector3.UP)


func _get_suitable_waypoints() -> Array:
	var result : Array = []
	for waypoint in _roadway._waypoints:
		var distance := _observer.global_transform.origin.distance_to(waypoint.global_transform.origin)
		if distance == clamp(distance, _min_distance, _max_distance):
			result.append(waypoint)
	return result


func _determine_waypoint_direction(waypoint : Waypoint) -> Vector3:
	return -waypoint.get_average_offset()


func _pull_rand_waypoint(waypoints : Array) -> Waypoint:
	var rand_index := _get_rand_array_index(_rng, waypoints)
	var waypoint : Waypoint = waypoints[rand_index]
	waypoints.remove(rand_index)
	return waypoint


func _get_rand_array_index(rng : RandomNumberGenerator, array : Array) -> int:
	return rng.randi_range(0, array.size() - 1)
