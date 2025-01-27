class_name SOUNDS
extends Node

static var INSTANCE

@onready var pop = $Pop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	INSTANCE = self
