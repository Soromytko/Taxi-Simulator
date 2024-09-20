extends Spatial

export var _brakeable_node_path : NodePath
onready var _brakeable : Node = get_node_or_null(_brakeable_node_path)
onready var _turned_on_light : Spatial = $TurnedOnLight
onready var _turned_off_light : Spatial = $TurnedOffLight


func _ready():
	if !_brakeable.has_signal("is_braking_changed") || _brakeable == null:
		push_warning("%s is not a Brakeable object" % _brakeable_node_path)
		return
	_brakeable.connect("is_braking_changed", self, "_on_is_braking_changed")


func _on_is_braking_changed(value : bool):
	_turned_on_light.visible = value
	_turned_off_light.visible = !value
