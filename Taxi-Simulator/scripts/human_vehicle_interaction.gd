class_name HumanVehicleInteraction


static func get_into_vehicle_instantly(vehicle : Vehicle, driver : RiderCharacter):
	if vehicle.has_driver() || driver.is_into_vehicle:
		return
	vehicle.set_driver(driver)
	driver.get_parent().remove_child(driver)
	vehicle.add_child(driver)
	driver.visible = false
	driver.global_transform.origin = vehicle.global_transform.origin
	driver.rotation = Vector3(0, PI, 0)
	driver.get_into_vehicle_instantly(vehicle, VehicleSeat.Type.LeftFrontDriver)


static func get_out_of_vehicle_instantly(vehicle : Vehicle, driver : RiderCharacter):
	vehicle.remove_driver()
	var scene_tree : SceneTree = driver.get_tree()
	var driver_position : Vector3 = driver.global_transform.origin + vehicle.global_transform.basis.x * 2
	driver.get_out_of_vehicle_instantly()
	driver.get_parent().remove_child(driver)
	scene_tree.root.add_child(driver)
	driver.global_transform.origin = driver_position
	driver.visible = true
