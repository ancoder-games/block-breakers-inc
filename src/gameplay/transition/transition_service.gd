@icon("res://addons/at-icons/node/clapperboard.svg")
extends CanvasLayer
class_name TransitionService

const SERVICE_ID: StringName = "TransitionService"

func _enter_tree() -> void:
    Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
    Services.unregister(SERVICE_ID)

@onready var anim: AnimationPlayer = %AnimationPlayer

func transition_in() -> void:
    anim.play("transition_in")
    await anim.animation_finished

func transition_out() -> void:
    anim.play("transition_out")
    await anim.animation_finished