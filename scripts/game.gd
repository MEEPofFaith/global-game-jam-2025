class_name GAME
extends Node2D

static var INSTANCE
var bubbles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INSTANCE = self

func remove_bubble(bubble) -> bool:
	bubble.queue_free()
	return true

func reset() -> void:
	PLAYER.INSTANCE.position = Vector2(0, 0)
	bubbles.all(remove_bubble)
	bubbles.clear()
