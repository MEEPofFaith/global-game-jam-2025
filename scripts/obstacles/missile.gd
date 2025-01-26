extends RigidBody2D

func _ready() -> void:
	GAME.INSTANCE.spawns.append(self)
	contact_monitor = true
	max_contacts_reported = 10

func _on_body_entered(body: Node) -> void:
	if body is BUBBLE:
		body.oof()
	else:
		GAME.INSTANCE.spawns.erase(self)
		queue_free()
