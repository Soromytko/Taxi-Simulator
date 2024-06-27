extends RandomNumberGenerator
class_name TimedRNG


func _init():
	var hashed := Time.get_time_dict_from_system().hash()
	set_seed(hashed)
