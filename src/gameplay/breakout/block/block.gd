extends StaticBody2D
class_name Block

@export var health: int = 5:
	set(value): health = value; if health < 0: _destroy()

func _destroy() -> void:
	queue_free()