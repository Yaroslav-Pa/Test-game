extends Area2D

const explosionn = preload("res://addons/Explosion.tscn")

func _ready():
	pass
	

func _on_FireBall_body_entered(body):
	var explosion = explosionn.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
