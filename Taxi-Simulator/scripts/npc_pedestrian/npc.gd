extends KinematicBody
class_name NPC

onready var _movement_controller : NPCMovementController = $MovementController
onready var _animator : Animator = $WomanCharacter


func _ready():
	_animator.start_playback("idle-loop")

