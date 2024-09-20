class_name CharacterVehicleInteraction


static func get_into_vehicle_instantly(vehicle : Vehicle, rider : RiderCharacter, seat_key : String = "driver"):
	if vehicle.has_rider(seat_key) || rider.has_vehicle():
		return
	var seat : VehicleSeat = vehicle.seats[seat_key]
	seat.rider = rider
	rider.get_parent().remove_child(rider)
	vehicle.seats[seat_key].add_child(rider)
	rider.visible = false
	rider.global_transform.origin = seat.global_transform.origin
	rider.rotation = Vector3(0, PI, 0)
	rider.get_into_vehicle_instantly(vehicle, seat_key)


static func get_out_of_vehicle_instantly(vehicle : Vehicle, rider : RiderCharacter):
	var seat_key : String = rider.get_parent().key
	vehicle.remove_rider(seat_key)
	var scene_tree : SceneTree = rider.get_tree()
	var rider_position : Vector3 = rider.global_transform.origin + vehicle.global_transform.basis.x * 2
	rider_position.y = vehicle.global_transform.origin.y
	rider.get_out_of_vehicle_instantly()
	rider.get_parent().remove_child(rider)
	scene_tree.root.add_child(rider)
	rider.global_transform.origin = rider_position
	rider.visible = true
