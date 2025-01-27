class_name GAME
extends Node2D

static var INSTANCE
var levels := [
	preload("res://scenes/levels/level1.tscn"),
	preload("res://scenes/levels/level2.tscn"),
	preload("res://scenes/levels/level3.tscn")
]
var currentLevel
var currentLevelIndex = 0
var spawns = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INSTANCE = self
	
func spawn(object) -> void:
	currentLevel.add_child(object)
	spawns.append(object)

func despawn(object) -> void:
	spawns.erase(object)
	object.queue_free()

func reset() -> void:
	PLAYER.INSTANCE.position = Vector2(0, 0)
	PLAYER.INSTANCE.velocity = Vector2(0, 0)
	spawns.all(
		func(object):
			object.queue_free()
			return true
	)
	spawns.clear()

func play_death_sound() -> void:
	$Death.play()

func start_level(toStart) -> void:
	if currentLevel != null: currentLevel.queue_free()
	currentLevel = levels[toStart].instantiate()
	$Game.visible = true
	$Game.add_child(currentLevel)
	currentLevelIndex = toStart
	spawns.clear()
	reset()

func next_level() -> void:
	start_level(currentLevelIndex + 1)
