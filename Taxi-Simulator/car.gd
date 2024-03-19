extends VehicleBody

export(float) var max_steer = 0.8

func _process(delta):
	var axis = Input.get_axis("ui_up", "ui_down")
	steering = move_toward(steering, axis * max_steer, delta * 2)
	engine_force = axis * 300
	print(axis)
