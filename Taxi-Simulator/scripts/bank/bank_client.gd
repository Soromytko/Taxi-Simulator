extends Node
class_name BankClient

signal funds_changed(value)
export var bank_name : String
export var funds : float setget set_funds, get_funds
var _funds : float


func get_funds() -> float:
	return _funds


func set_funds(value : float):
	if _funds != value:
		_funds = value
		emit_signal("funds_changed", value)


func credit_funds(amount : float):
	set_funds(_funds + amount) 


func dedit_funds(amount : float):
	set_funds(_funds - amount) 



