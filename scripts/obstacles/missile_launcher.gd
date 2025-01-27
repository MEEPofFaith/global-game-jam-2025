extends StaticBody2D

const MISSILE := preload("res://scenes/obstacles/missile.tscn")
@export var shotInterval: float
@export var shotDelay: float
@export var velocity: float
var shotTimer = shotDelay


func _ready() -> void:
	shotTimer = shotDelay;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shotTimer -= delta;
	if shotTimer < 0:
		shotTimer = shotInterval
		var m = MISSILE.instantiate()
		m.position = global_position
		m.rotation = rotation
		m.linear_velocity = Vector2(velocity, 0).rotated(rotation)
		m.scale = scale
		GAME.INSTANCE.spawn(m)
