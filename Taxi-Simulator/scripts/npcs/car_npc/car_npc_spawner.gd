extends NPCSpawner
class_name CarNPCSpawner


func _on_spawn_npc_deferred(npc : PhysicsBody, waypoint : Waypoint):
	._on_spawn_npc_deferred(npc, waypoint)
	if npc is CarNPC:
		var car_npc : CarNPC = npc
		car_npc.start_walking()
		

