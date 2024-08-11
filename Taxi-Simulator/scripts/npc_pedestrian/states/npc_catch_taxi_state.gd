extends "./npc_movement_state.gd"

const ROTATION_SPEED : float = 5.0

onready var _taxi_catching_on := BooleanAnimatorProperty.new(_animator, "taxi_catching_on")
onready var _taxi_catching_off := BooleanAnimatorProperty.new(_animator, "taxi_catching_off")
var _taxi_car : TaxiCar = null


func _on_enter():
	_enable_vision()
	_taxi_catching_on.value = true
	_taxi_catching_off.value = false


func _on_physics_update(delta : float):
	if !_taxi_car:
		return
	_rotate_character(_taxi_car.global_transform.origin, ROTATION_SPEED * delta)


func _on_exit():
	_disable_vision()
	_taxi_catching_on.value = false
	_taxi_catching_off.value = true


func _on_vision_body_entered(body : PhysicsBody):
	if body is TaxiCar:
		_taxi_car = body


func _on_vision_body_exited(body : PhysicsBody):
	if body is TaxiCar:
		_taxi_car = null


func _rotate_character(target : Vector3, speed : float):
	var character := _get_character()
	var helper := character.global_transform.looking_at(target, Vector3.UP)
	var basis := character.global_transform.basis
	basis = basis.slerp(helper.basis, speed)
	character.global_transform.basis = basis
	character.rotation.x = 0
	character.rotation.z = 0

