extends Area2D

const explosionn = preload("res://addons/Explosion.tscn")
const speed = 10

func _ready():
	pass

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed 
	

func _on_FireBall_body_entered(body):
	var explosion = explosionn.instance()
	explosion.position = position
	get_parent().call_deferred("add_child", explosion)
	queue_free()
