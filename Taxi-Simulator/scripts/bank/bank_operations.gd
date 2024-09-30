class_name BankOperations


static func find_bank(scene_tree : SceneTree, bank_name : String) -> Bank:
	var banks := scene_tree.get_nodes_in_group("banks")
	for maybe_bank in banks:
		if maybe_bank.name == bank_name:
			return maybe_bank
	return null


static func credit_funds(scene_tree : SceneTree, bank_name : String, client_name : String, amount : float) -> bool:
	var client : BankClient = _find_client(scene_tree, bank_name, client_name)
	if client:
		client.credit_funds(amount)
		return true
	return false


static func debit_funds(scene_tree : SceneTree, bank_name : String, client_name : String, amount : float) -> bool:
	var client : BankClient = _find_client(scene_tree, bank_name, client_name)
	if client:
		client.debit_funds(amount)
		return true
	return false


static func _find_client(scene_tree : SceneTree, bank_name : String, client_name : String) -> BankClient:
	var bank : Bank = find_bank(scene_tree, bank_name)
	if bank:
		return bank.get_client(client_name)
	return null

