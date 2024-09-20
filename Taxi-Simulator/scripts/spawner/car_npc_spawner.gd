extends NPCSpawner
class_name CarNPCSpawner

export(Array, PackedScene) var _driver_packed_scenes : Array = []


func _on_spawn_npc_deferred(npc : PhysicsBody, waypoint : Waypoint):
	._on_spawn_npc_deferred(npc, waypoint)
	if npc is Vehicle:
		var car : Vehicle = npc
		var driver := _spawn_driver()
		CharacterVehicleInteraction.get_into_vehicle_instantly(car, driver)


func _spawn_driver() -> NPC:
	var rand_index := _get_rand_array_index(_rng, _driver_packed_scenes)
	var result = _driver_packed_scenes[rand_index].instance()
	add_child(result)
	return result

