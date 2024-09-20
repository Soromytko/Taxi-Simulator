extends Interactable
class_name CarDoorInteractable


#overridden
func interact(some_arg = null):
	if some_arg is RiderCharacter:
		var rider : RiderCharacter = some_arg
		var vehicle : Vehicle = get_parent()
		CharacterVehicleInteraction.get_into_vehicle_instantly(vehicle, rider)
