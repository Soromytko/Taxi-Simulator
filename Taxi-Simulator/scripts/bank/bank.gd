extends Node
class_name Bank


func get_clients() -> Array:
	var result : Array = []
	var clients := get_tree().get_nodes_in_group("bank_clients")
	for maybe_client in clients:
		if maybe_client is BankClient:
			var client : BankClient = maybe_client
			if client.bank_name == name:
				result.append(client)
	return result


func get_client(client_name : String) -> BankClient:
	for client in get_clients():
		if client.bank_name == name:
			return client
	return null
