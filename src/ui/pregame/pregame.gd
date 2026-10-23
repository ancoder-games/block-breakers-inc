extends Control

@onready var start_button: Button = %StartButton

@onready var breakout_service: BreakoutService = Services.get(BreakoutService.SERVICE_ID)
@onready var transition_service: TransitionService = Services.get(TransitionService.SERVICE_ID)

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	await transition_service.transition_in()
	hide()
	breakout_service.start()
	await transition_service.transition_out()