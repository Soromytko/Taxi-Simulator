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


func _ready():
	var rng := TimedRNG.new()
	for i in _instance_count:
		var rand_index := _get_rand_index(rng)
		var rand_pos := _get_rand_pos(rng)
		var npc := _spawn_npc(rand_index, rand_pos)
		continue
		var nearest_waypoint := _roadway.get_nearest_waypoint(npc.global_transform.origin)
		npc.global_transform.origin = nearest_waypoint.global_transform.origin + \
			Vector3(rng.randf_range(-2, 2), 0, rng.randf_range(-2, 2))


func _spawn_npc(index : int, position : Vector3) -> NPC:
	var npc : NPC = _npc_packed_scenes[index].instance()
	call_deferred("_init_npc", npc, position)
	return npc


func _init_npc(npc, position : Vector3):
	add_child(npc)
	npc.global_transform.origin = position


func _get_rand_index(rng : TimedRNG) -> int:
	return rng.randi_range(0, _npc_packed_scenes.size() - 1)


func _get_rand_pos(rng : TimedRNG) -> Vector3:
	var rand_direction := Vector3(
		rng.randf_range(1, 2),
		0,
		rng.randf_range(1, 2)
	).normalized() * (-1 if rng.randi_range(0, 1) == 0 else 1)
	var rand_distance := rng.randf_range(_min_distance, _max_distance)
	return rand_direction * rand_distance
