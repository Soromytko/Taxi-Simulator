class_name RWUtils


static func find_roadway(tree : SceneTree, roadway_name : String) -> Roadway:
	var roadways := tree.get_nodes_in_group("Roadways")
	var maybe_roadway := find_node_with_name(roadways, roadway_name)
	var index := roadways.find(roadway_name)
	if maybe_roadway == null:
		push_warning("Roadway named %s not found" % roadway_name)
		return null
	if !(maybe_roadway is Roadway):
		push_warning("The %s object is not a Roadway" % [maybe_roadway])
		return null
	return maybe_roadway as Roadway


static func find_node_with_name(array : Array, node_name : String) -> Node:
	for node in array:
		if node && node.name == node_name:
			return node
	return null

