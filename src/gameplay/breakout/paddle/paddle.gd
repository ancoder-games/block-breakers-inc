extends CharacterBody2D
class_name Paddle

@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var speed: float = 300.0

func _physics_process(delta: float) -> void:
	move_and_collide(Vector2(Input.get_axis("left", "right") * speed * delta, 0))
