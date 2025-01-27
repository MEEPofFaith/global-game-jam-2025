extends Control

@onready var Menu = $MainMenu
@onready var StartButton = $MainMenu/VBoxContainer/StartButton
@onready var LevelsButton = $MainMenu/VBoxContainer/LevelsButton
var game = preload("res://scenes/game.tscn")

func _on_start_button_pressed() -> void:
	add_child(game.instantiate())
	GAME.INSTANCE.start_level(0)
	Menu.visible = false

func _on_levels_button_pressed() -> void:
	print("No levels to select...")
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and !Menu.visible:
		GAME.INSTANCE.queue_free()
		Menu.visible = true
