extends Spatial

var _mesh_instance : MeshInstance


func get_mesh_instance() -> MeshInstance:
	return _mesh_instance


func _enter_tree():
	_init_mesh_instance()


func _exit_tree():
	_release_mesh_instance()


func rasterize(road_elements : Array):
	if road_elements.size() < 2:
		return
	var vertices := _create_vertices(road_elements)
	var indices := _create_indices(road_elements)
	var data = []
	data.resize(ArrayMesh.ARRAY_MAX)
	data[ArrayMesh.ARRAY_VERTEX] = vertices
	data[ArrayMesh.ARRAY_INDEX] = indices
	var mesh := ArrayMesh.new()
	mesh.add_surface_from_arrays(ArrayMesh.PRIMITIVE_TRIANGLES, data)
	_mesh_instance.mesh = mesh


func _create_vertices(road_elements : Array) -> PoolVector3Array:
	var vertices : PoolVector3Array
	vertices.resize(road_elements.size() * 2)
	for i in road_elements.size():
		var road_element : Spatial = road_elements[i]
		var origin := road_element.transform.origin
		var x_basis := road_element.global_transform.basis.x 
		vertices[i] = origin + x_basis
		vertices[i + road_elements.size()] = origin - x_basis
	return vertices


func _create_indices(road_elements : Array) -> PoolIntArray:
	var indices : PoolIntArray
	var size := road_elements.size()
	indices.resize((size - 1) * 6)
	for i in range(0, size - 1, 4):
		indices[0 + i] = i + 0
		indices[1 + i] = i + 1 + size
		indices[2 + i] = i + 0 + size
		indices[3 + i] = i + 0
		indices[4 + i] = i + 1
		indices[5 + i] = i + 1 + size
	return indices


func _init_mesh_instance():
	_mesh_instance = MeshInstance.new()
	add_child(_mesh_instance)


func _release_mesh_instance():
	remove_child(_mesh_instance)
	_mesh_instance.queue_free()
	_mesh_instance = null

