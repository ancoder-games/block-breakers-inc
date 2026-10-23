extends Node2D
class_name CardService

const SERVICE_ID: StringName = "CardService"

func _enter_tree() -> void:
    Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
    Services.unregister(SERVICE_ID)
