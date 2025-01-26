extends CharacterBody2D

const FIREPOWER = 50.0
const BUBBLECOOLDOWN = 0.5
const BUBBLE := preload("res://scenes/bubble.tscn")
var bubbleTimer = 0
@export var wandLength: float

func can_shoot() -> bool:
	var coll = get_node("Bubble Check")
	return !coll.has_overlapping_bodies()

func _process(delta) -> void:
	var mousePos = get_global_mouse_position()
	look_at(mousePos)
	bubbleTimer -= delta
	#if Input.is_action_pressed("shoot"): (Madness Mode) (Oh god oh fuck)
	if bubbleTimer <= 0 and Input.is_action_pressed("shoot") and can_shoot():
		bubbleTimer = BUBBLECOOLDOWN
		var b = BUBBLE.instantiate()
		var ang = global_position.angle_to_point(mousePos)
		b.position = global_position + Vector2(wandLength, 0).rotated(ang)
		#b.linear_velocity = PLAYER.INSTANCE.get_real_velocity() + Vector2(FIREPOWER, 0).rotated(ang)
		b.linear_velocity = Vector2(FIREPOWER, 0).rotated(ang)
		GAME.INSTANCE.add_child(b)
		
