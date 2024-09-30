tool
extends Position3D
class_name VehicleSeat

const APPROACH_NAME = "Approach"

signal rider_changed(value)

var rider : Spatial setget set_rider, get_rider
var approach : Position3D setget , get_approach
export var is_driver_seat : bool setget set_is_driver_seat, get_is_driver_seat
export var key : String setget set_key, get_key
export var anim_name : String setget set_anim_name, get_anim_name
var _is_driver_seat : bool
var _key : String = "rider"
var _anim_name : String
var _rider : Spatial
var _approach : Position3D


func set_is_driver_seat(value : bool):
	_is_driver_seat = value


func get_is_driver_seat() -> bool:
	return _is_driver_seat


func set_rider(value : Spatial):
	if _rider != value:
		_rider = value
		emit_signal("rider_changed", value)


func get_rider() -> Spatial:
	return _rider


func get_approach() -> Position3D:
	return _approach


func set_key(value : String):
	_key = value


func get_key() -> String:
	return _key


func set_anim_name(value : String):
	_anim_name = value


func get_anim_name() -> String:
	return _anim_name


func _ready():
	var maybe_approach = get_node_or_null(APPROACH_NAME)
	if maybe_approach && maybe_approach is Position3D:
		_approach = maybe_approach
	else:
		_approach = Position3D.new()
		add_child(_approach)
		_approach.owner = owner
		_approach.name = APPROACH_NAME

