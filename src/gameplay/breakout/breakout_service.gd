extends Node2D
class_name BreakoutService

const SERVICE_ID: StringName = "BreakoutService"

func _enter_tree() -> void:
	Services.register(SERVICE_ID, self)

func _exit_tree() -> void:
	Services.unregister(SERVICE_ID)

@onready var transition_service: TransitionService = Services.get(TransitionService.SERVICE_ID)

@export_group("References")
@export_subgroup("Scenes")
@export var ball_scene: PackedScene
@export var block_scene: PackedScene
@export var paddle_scene: PackedScene
@export_subgroup("Nodes")
@export var death_area: Area2D
@export var ball_spawn: Marker2D
@export var paddle_spawn: Marker2D
@export var blocks: Array[StaticBody2D] # TODO: Dynamic block spawing

func _ready() -> void:
	death_area.body_entered.connect(_on_body_entered_death_area)

func _physics_process(_delta: float) -> void:
	if blocks.filter(func(b: Variant) -> bool: return is_instance_valid(b)).size() == 0:
		end()
		
func _on_body_entered_death_area(body: Node) -> void:
	if body is Ball:
		end()

func spawn_ball() -> void:
	var ball: Ball = ball_scene.instantiate()
	add_child(ball)
	ball.global_transform = ball_spawn.global_transform
	ball.enabled = true

func spawn_paddle() -> void:
	var paddle: Paddle = paddle_scene.instantiate()
	add_child(paddle)
	paddle.global_transform = paddle_spawn.global_transform

func start() -> void:
	spawn_ball()
	spawn_paddle()

func end() -> void:
	# TODO: implement actual end sequence
	set_physics_process(false)
	await transition_service.transition_in()
	get_tree().reload_current_scene()
