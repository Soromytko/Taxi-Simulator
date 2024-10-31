extends Label
class_name StatLabel

export var _stat_node_path : NodePath
onready var _stat : Stat = get_node(_stat_node_path)


func _ready():
	_stat.connect("current_value_changed", self, "_on_current_value_changed")
	_on_current_value_changed(_stat.current_value)


func _on_current_value_changed(value : float):
	text = str(value)
