extends StaticBody2D

@export var length: float
@export var interval: float = 4
@export var duration: float = 1
@export var offset: float
var timer

func _ready() -> void:
	timer = offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > interval: timer = 0
	if timer < duration:
		$Beam.scale = Vector2(length, 1)
		$Beam.position = Vector2(length / 2, 0) # I don't think I can change the pivot point of a collision box...
	else:
		$Beam.scale = Vector2(0, 1)
		$Beam.position = Vector2(0, 0)
