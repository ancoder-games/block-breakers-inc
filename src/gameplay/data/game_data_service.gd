@icon("res://addons/at-icons/node/floppy_disk.svg")
extends Node
class_name GameDataService

const SERVICE_ID: StringName = "GameDataService"

func _enter_tree() -> void:
    Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
    Services.unregister(SERVICE_ID)

var coins: float = 0.0