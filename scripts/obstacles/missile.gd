extends RigidBody2D

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10

func _on_body_entered(body: Node) -> void:
	if body is BUBBLE:
		GAME.INSTANCE.despawn(body)
		SOUNDS.INSTANCE.pop.play()
	else:
		GAME.INSTANCE.despawn(self)
