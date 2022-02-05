extends KinematicBody2D

export var speed = 400
export (float, 0, 1.0) var acceleration = 0.002

var velocity = Vector2.ZERO
var bullet = 2

func _physics_process(delta):
	velocity.y -= speed * acceleration
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.get_collision_layer() == 1:
			collision.collider.damage()


func kill():
	GLOBAL.enemy_count -= 1
	queue_free()
