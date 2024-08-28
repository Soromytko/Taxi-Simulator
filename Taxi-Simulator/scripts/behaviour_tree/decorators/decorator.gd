extends BTNodeWithBlackboard
class_name BTDecorator


func on_check(_delta : float) -> bool:
	push_warning("Override me!")
	return true
