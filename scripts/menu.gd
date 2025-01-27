class_name MENU
extends Control

static var INSTANCE

@onready var MainMenu = $MainMenu
@onready var MainButtons = $MainMenu/MainButtons
@onready var StartButton = $MainMenu/MainButtons/StartButton
@onready var LevelsButton = $MainMenu/MainButtons/LevelsButton
@onready var LevelSelect = $MainMenu/LevelSelect
@onready var WinScreen = $MainMenu/WinScreen
@onready var Music = $Music
var game = preload("res://scenes/game.tscn")

func _ready() -> void:
	INSTANCE = self

func _on_start_button_pressed() -> void:
	start_level(0)

func _on_levels_button_pressed() -> void:
	MainButtons.visible = false
	LevelSelect.visible = true

func _on_back_button_pressed() -> void:
	MainButtons.visible = true
	LevelSelect.visible = false

func _on_win_back_pressed() -> void:
	MainButtons.visible = true
	WinScreen.visible = false
	Music.stop()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and !MainMenu.visible:
		GAME.INSTANCE.queue_free()
		MainMenu.visible = true
		_on_back_button_pressed()
		Music.stop()

func win() -> void:
	GAME.INSTANCE.queue_free()
	MainMenu.visible = true
	MainButtons.visible = false
	LevelSelect.visible = false
	WinScreen.visible = true

func start_level(level) -> void:
	add_child(game.instantiate())
	GAME.INSTANCE.start_level(level)
	MainMenu.visible = false
	Music.play()

# Does anyone know how to not hardcode this?
func _on_level_1_pressed() -> void:
	start_level(0)

func _on_level_2_pressed() -> void:
	start_level(1)

func _on_level_3_pressed() -> void:
	start_level(2)
