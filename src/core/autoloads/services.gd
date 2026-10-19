extends Node

## Services.gd is an autoload singleton that allows other nodes in the tree to register themselves as a "service".
## A service is a singleton that does not clutter globals. [br]
## Usage: [br]
## Get a service using [method Services.get(id)].
## Always call [method Services.unregister(id)] when a node leaves the tree.

var _services: Dictionary[StringName, Node] = {}

## Registers a service under [param id].
func register(id: StringName, service: Node) -> void:
	if _services.has(id):
		Log.error("[Services] Service %s has been registered twice!" % id)
		return

	_services.set(id, service)
	Log.info("[Services] Service %s has been registered!" % id)

## Unregisters a service under [param id].
func unregister(id: StringName) -> void:
	if not _services.has(id):
		Log.error("[Services] Tried to unregister \"%s\"; but it does not exist!" % id)
		return
	_services.erase(id)
	Log.info("[Services] Service %s has been unregistered!" % id)

func _get(id: StringName) -> Variant:
	if not _services.has(id):
		Log.error("[Services] Tried to get service %s which does not exist!" % id)

	return _services.get(id)
