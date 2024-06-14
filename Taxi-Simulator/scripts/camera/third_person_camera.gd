extends Spatial

export var target_node_path : NodePath
export var sharpness : float = 2.0 
export var sensitivity = 0.4
export var target_distance : float = 3
export var acceleration = 20
export var minimum_angle = -80
export var maximum_angle = +75

onready var _target : Spatial = get_node(target_node_path)

var _instant_mouse = Vector2(0, 0)
var _smoothed_mouse = Vector2(0, 0)


func _ready():
	$Pivot.spring_length = target_distance
	#Ensure that the camera is processed after the target moves
	process_priority = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		_instant_mouse.x += -event.relative.x * sensitivity
		_instant_mouse.y += -event.relative.y * sensitivity
		_instant_mouse.y = clamp(_instant_mouse.y, minimum_angle, maximum_angle)
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	_process_rotation(delta)
	_follow_target(delta)


func _process_rotation(delta : float):
	var speed = acceleration * delta
	_smoothed_mouse.x = lerp(_smoothed_mouse.x, _instant_mouse.x, speed)
	_smoothed_mouse.y = lerp(_smoothed_mouse.y, _instant_mouse.y, speed)
	$Pivot.rotation_degrees.x = _smoothed_mouse.y
#	$Pivot.rotation_degrees.y = _smoothed_mouse.x
	rotation_degrees.y = _smoothed_mouse.x


func _follow_target(delta : float):
	if _target != null:
		global_transform.origin = lerp(global_transform.origin, _target.global_transform.origin, sharpness * delta)
