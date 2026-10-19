extends Node2D
class_name BreakoutService

const SERVICE_ID: StringName = "BreakoutService"

func _enter_tree() -> void:
    Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
    Services.unregister(SERVICE_ID)
