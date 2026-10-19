extends Camera2D
class_name CameraService

const SERVICE_ID: StringName = "CameraService"

func _enter_tree() -> void:
    Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
    Services.unregister(SERVICE_ID)

#region Screen Shake

var shake_intensity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise: FastNoiseLite = FastNoiseLite.new()

func _physics_process(delta: float) -> void:
    if active_shake_time > 0:
        shake_time += delta * shake_time_speed
        active_shake_time -= delta

        offset = Vector2(
            noise.get_noise_2d(shake_time, 0) * shake_intensity,
            noise.get_noise_2d(0, shake_time) * shake_intensity,
        )

        shake_intensity = max(shake_intensity - shake_decay * delta, 0)
    else:
        offset = lerp(offset, Vector2.ZERO, 10.5 * delta)

func screen_shake(intensity: int, time: float) -> void:
    randomize()
    noise.seed = randi()
    noise.frequency = 2

    shake_intensity = intensity
    active_shake_time = time
    shake_time = 0.0

func freeze_frame(time_scale: float, duration: float) -> void:
    Engine.time_scale = time_scale
    await get_tree().create_timer(duration, true, false, true).timeout
    Engine.time_scale = 1.0