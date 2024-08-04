extends Spatial

var _line : ImmediateGeometry


func _ready():
	_line = ImmediateGeometry.new()
	add_child(_line)


func draw(start : Vector3, end : Vector3, color : Color = Color.white):
	clear()
#	get_tree().get_root().add_child(_line)
	_line.transform.origin = Vector3.ZERO
	_line.begin(Mesh.PRIMITIVE_LINE_STRIP)
	_line.set_material_override(_create_material())
	_line.set_color(color)
	_line.add_vertex(to_local(start))
	_line.add_vertex(to_local(end))
	_line.end()


func clear():
	if _line != null:
		_line.clear()


func _create_material() -> SpatialMaterial:
	var material := SpatialMaterial.new()
	material.vertex_color_use_as_albedo = true 
	material.flags_use_point_size = true
	return material
