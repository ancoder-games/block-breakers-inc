extends Line2D

@export var follow: Node2D
@export var max_points: float = 30

func _ready() -> void:
	top_level = true
	z_index = -1
	global_transform = Transform2D.IDENTITY

func _physics_process(_delta: float) -> void:
	add_point(to_local(follow.global_position))
	if points.size() > max_points:
		remove_point(0)
