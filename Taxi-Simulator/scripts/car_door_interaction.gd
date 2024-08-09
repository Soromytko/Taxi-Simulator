extends Interaction


export var _left_back_door_interactable_node_path : NodePath
export var _left_front_door_interactable_node_path : NodePath
onready var _left_back_door_interactable = get_node(_left_back_door_interactable_node_path)
onready var _left_front_door_interactable = get_node(_left_front_door_interactable_node_path)


func _ready():
	_left_back_door_interactable.connect("interacted", self, "_on_left_back_door_interacted")
	_left_front_door_interactable.connect("interacted", self, "_on_left_front_door_interacted")


func _on_left_back_door_interacted(_interactor):
	pass


func _on_left_front_door_interacted(_interactor):
	pass
