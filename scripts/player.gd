class_name PLAYER
extends CharacterBody2D

static var INSTANCE

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const BUBBLE_JUMP_VELOCITY = -600.0
var lastSide
var onBubble

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
	
	var mousePos = get_global_mouse_position()
	var side = mousePos.x > global_position.x
	if side != lastSide:
		apply_scale(Vector2(-1, 1))
	lastSide = side
