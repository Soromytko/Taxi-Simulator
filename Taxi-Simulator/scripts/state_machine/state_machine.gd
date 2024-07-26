extends Node
class_name StateMachine

export(NodePath) var initial_state_node_path

onready var _initial_state : StateMachineState = get_node(initial_state_node_path)

var states = {}
var current_state_name : String
var current_state : StateMachineState = null


func _ready():
	for child in get_children():
		if child is StateMachineState:
			child.connect("transitioned", self, "_on_switch_state")
			add_state(child.name, child)
			if _initial_state == child:
				current_state = _initial_state


func add_state(state_name : String, state : StateMachineState):
	states[state_name] = state


func switch_state(state_name : String):
	if !states.has(state_name):
		print(state_name, " is a not state")
		return
	if current_state_name == state_name:
		return
		
	if current_state:
		current_state._on_exit()
	current_state = states[state_name]
	current_state_name = state_name
	current_state._on_enter()


func _on_switch_state(state_name : String):
	switch_state(state_name)


func _process(delta : float):
	if current_state:
		current_state._on_update(delta)


func _physics_process(delta : float):
	if current_state:
		current_state._on_physics_update(delta)

