extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body == PLAYER.INSTANCE:
		MENU.INSTANCE.win()
