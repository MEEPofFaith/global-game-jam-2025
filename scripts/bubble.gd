class_name BUBBLE
extends RigidBody2D

const GROWTIME = 0.1
@export var DRAG: float
var popping = false
var growTimer = GROWTIME
var popTimer = 0.5

func _ready() -> void:
	set_collision_layer_value(1, false)
	apply_scale(Vector2(0, 0))

func growf() -> float:
	return 1 - (growTimer / GROWTIME)

func grown() -> bool:
	return growTimer <= 0

func pop() -> void:
	if growTimer <= 0:
		popping = true

func _physics_process(delta: float) -> void:
	if growTimer > 0:
		growTimer -= delta
		var scl = 1 - (growTimer / GROWTIME)
		if scl > 1: scl = 1
		apply_scale(Vector2(scl, scl))
		if growTimer <= 0:
			set_collision_layer_value(1, true)
			linear_damp = DRAG
	
	if popping:
		popTimer -= delta
		if popTimer < 0:
			GAME.INSTANCE.despawn(self)
			SOUNDS.INSTANCE.pop.play()
