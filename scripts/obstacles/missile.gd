extends RigidBody2D

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10

func _on_body_entered(body: Node) -> void:
	if body is BUBBLE:
		GAME.INSTANCE.despawn(body)
		SOUNDS.INSTANCE.pop.play()
	elif (body is TileMapLayer) or (body is CollisionObject2D and body.get_collision_layer_value(2)):
		GAME.INSTANCE.despawn(self)
	elif body is PLAYER:
		GAME.INSTANCE.reset()
		SOUNDS.INSTANCE.pop.play()
