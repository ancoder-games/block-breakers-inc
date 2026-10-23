extends CharacterBody2D
class_name Ball

@onready var camera_service: CameraService = Services.get(CameraService.SERVICE_ID)

@export_category("Ball") # Remove if this ever gets a class_name
@export_group("Ball Stats")
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var speed: float = 300.0
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var max_speed: float = 2000.0

@export_group("Ball")
@export var enabled: bool = false:
	set(value): enabled = value; if is_node_ready(): _enable_updated(value)

@export_group("References")
@export var audio: AudioStreamPlayer

var wall_bounces: int = 0
var last_velocity: Vector2 = Vector2.ZERO

func _enable_updated(new: bool) -> void:
	set_physics_process(new)
	set_process(new)

func _ready() -> void:
	_enable_updated(enabled)

func _physics_process(_delta: float) -> void:
	velocity = global_transform.x.normalized() * min(max_speed, speed * ((wall_bounces * 0.025) + 1))
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		var collision: KinematicCollision2D = get_slide_collision(0)
		global_rotation = global_transform.x.bounce(collision.get_normal()).angle()
		
		var collider: Object = collision.get_collider()
		if collider is Walls or collider is Paddle:
			wall_bounces += 1
			camera_service.screen_shake(2 + int(6 * last_velocity.length_squared() / (max_speed * max_speed)), 0.1)
			audio.pitch_scale = 0.3
		else:
			wall_bounces = 0
			if collider is Block:
				var block: Block = collider
				block.health -= 1
				camera_service.screen_shake(10 + int(6 * last_velocity.length_squared() / (max_speed * max_speed)), 0.05)
			audio.pitch_scale = 0.5
		
		audio.play()

	last_velocity = velocity
