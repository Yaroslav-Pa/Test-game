extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Explosion_body_entered(body):
	if body.is_in_group("Player"):
#		body.impulse = Vector2.ONE *10 - body.global_position - self.global_position
		pass
		
