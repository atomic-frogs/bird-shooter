extends KinematicBody2D

class_name clouds

var speed = 10
var velocity = Vector2.ZERO
var dir = 0

func _physics_process(delta):
	velocity.x = speed * dir
	velocity.y = 0
	velocity = move_and_slide(velocity)


func kill():
	queue_free()
