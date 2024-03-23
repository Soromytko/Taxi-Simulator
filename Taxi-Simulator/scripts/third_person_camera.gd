extends Spatial

export(NodePath) var target_node_path
onready var target = get_node(target_node_path)

func _process(delta):
	if target != null:
		print(target.global_transform.origin)
		global_transform.origin = lerp(global_transform.origin, target.global_transform.origin, delta)
