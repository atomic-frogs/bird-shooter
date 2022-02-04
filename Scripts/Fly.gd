extends KinematicBody2D

export var speed = 100
export (float, 0, 1.0) var acceleration = 0.8

var velocity = Vector2.ZERO
var bullet = 1

func _physics_process(delta):
	velocity.y = lerp(velocity.y, -1 * speed, acceleration)
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.get_collision_layer() == 1:
			collision.collider.damage()
	


func kill():
	get_parent().enemy_count -= 1
	queue_free()
