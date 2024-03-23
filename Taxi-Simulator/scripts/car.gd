extends VehicleBody

export(float) var max_steer = 0.5

func _process(delta):
	var horizonal_axis = Input.get_axis("ui_right", "ui_left")
	var vertical_axis = Input.get_axis("ui_down", "ui_up")
	print(horizonal_axis)
	
	steering = move_toward(steering, horizonal_axis * max_steer, delta * 2)
	engine_force = vertical_axis * 100
