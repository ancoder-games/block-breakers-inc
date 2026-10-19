extends Node2D
class_name UpgradeService

const SERVICE_ID: StringName = "UpgradeService"

func _enter_tree() -> void:
    Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
    Services.unregister(SERVICE_ID)
