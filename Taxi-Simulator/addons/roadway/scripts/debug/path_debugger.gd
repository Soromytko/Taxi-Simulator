tool
extends Spatial

const TWO_POINTS_LINE_SCRIPT : Script = preload("two_points_line.gd")
const LINE_COLOR : Color = Color.black

var _lines : Array


func _enter_tree():
	assert(get_parent() is RWNavigationAgent)
	var navigation_agent : RWNavigationAgent = get_parent()
	if !navigation_agent.is_connected("path_points_changed", self, "_on_path_points_changed"):
		navigation_agent.connect("path_points_changed", self, "_on_path_points_changed")


func _process(delta : float):
	get_parent().get_next_path_position()


func _on_path_points_changed(path_points : Array):
	path_points = path_points.duplicate()
	path_points.push_front(get_parent().global_transform.origin)
	_resize_lines(path_points)
	_update_lines(path_points)


func _resize_lines(path_points : Array):
	if _lines.size() < path_points.size() - 1:
		for i in range(_lines.size(), path_points.size() - 1, 1):
			var line := TWO_POINTS_LINE_SCRIPT.new()
			line.color = LINE_COLOR
			_lines.append(line)
			add_child(line)
	elif _lines.size() > path_points.size() - 1:
		for i in range(path_points.size() - 1, _lines.size(), 1):
			var line : TWO_POINTS_LINE_SCRIPT = _lines[i]
			line.clear()
			line.queue_free()
			remove_child(line)
		_lines.resize(path_points.size() - 1)


func _update_lines(path_points : Array):
	for i in _lines.size():
		var line : TWO_POINTS_LINE_SCRIPT = _lines[i]
		line.start_point = path_points[i]
		line.end_point = path_points[i + 1]

