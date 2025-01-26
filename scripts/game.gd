class_name GAME
extends Node2D

static var INSTANCE
var spawns = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INSTANCE = self

func delete_spawn(object) -> bool:
	object.queue_free()
	return true

func reset() -> void:
	PLAYER.INSTANCE.position = Vector2(0, 0)
	spawns.all(delete_spawn)
	spawns.clear()
