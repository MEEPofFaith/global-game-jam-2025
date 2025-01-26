class_name PLAYER
extends CharacterBody2D

static var INSTANCE

# Player stuff
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const BUBBLE_JUMP_VELOCITY = -600.0
var lastSide
var onBubble

# Bubble launching stuff
const FIREPOWER = 50.0
const BUBBLECOOLDOWN = 0.5
const BUBBLE := preload("res://scenes/bubble.tscn")
var bubbleTimer = 0
@export var shotDist: float

func _ready() -> void:
	var mousePos = get_global_mouse_position()
	var side = mousePos.x > global_position.x
	if !side: apply_scale(Vector2(-1, 1))
	lastSide = side
	INSTANCE = self
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if onBubble:
			velocity.y = BUBBLE_JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	onBubble = false
	if move_and_slide():
		for i in range(get_slide_collision_count()):
			var collided = get_slide_collision(i).get_collider()
			if collided is BUBBLE:
				collided.pop()
				if is_on_floor_only(): onBubble = true
			elif collided is CollisionObject2D and collided.get_collision_layer_value(3):
				GAME.INSTANCE.reset()
	
	var mousePos = get_global_mouse_position()
	var side = mousePos.x > global_position.x
	if side != lastSide:
		apply_scale(Vector2(-1, 1))
	lastSide = side

func _process(delta) -> void:
	var coll = get_node("Bubble Check")
	var mousePos = get_global_mouse_position()
	coll.look_at(mousePos)
	bubbleTimer -= delta
	#if Input.is_action_pressed("shoot"): # (Madness Mode) (Oh god oh fuck)
	if bubbleTimer <= 0 and Input.is_action_pressed("shoot") and !coll.has_overlapping_bodies():
		bubbleTimer = BUBBLECOOLDOWN
		var b = BUBBLE.instantiate()
		var ang = global_position.angle_to_point(mousePos)
		b.position = global_position + Vector2(shotDist, 0).rotated(ang)
		b.linear_velocity = PLAYER.INSTANCE.get_real_velocity() + Vector2(FIREPOWER, 0).rotated(ang)
		#b.linear_velocity = Vector2(FIREPOWER, 0).rotated(ang)
		GAME.INSTANCE.add_child(b)
