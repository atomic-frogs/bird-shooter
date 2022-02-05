extends KinematicBody2D

export var speed = 100
export var gravity = 400
export var jump_speed = 400
export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.8

var velocity = Vector2.ZERO
var dir = 0
var lifes = 3
var bullets = 3

onready var sprite = $Sprite
onready var muzzle_flash = $MuzzleFlash
onready var jump_sound = $jump_sound
onready var shoot_sound = $shooting_sound
onready var animations = $AnimationPlayer
onready var raycast = $MuzzleFlash/RayCast2D
onready var firing_timer = $firing_rate

func _physics_process(delta):
	get_input()
	if shoot() or jump():
		velocity.y = -jump_speed
	else:
		if velocity.y > 0:
			pass
	if lifes <= 0:
		death()
	#print(bullets)
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, -gravity, gravity)
	velocity = move_and_slide(velocity)

func get_input():
	dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
		sprite.flip_h = 0
		muzzle_flash.position.x = 4
	if Input.is_action_pressed("left"):
		dir -= 1
		sprite.flip_h = 1
		muzzle_flash.position.x = -4
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func jump():
	if Input.is_action_just_pressed("up"):
		jump_sound.play()
		return true

func shoot():
	if Input.is_action_just_pressed("up") and firing_timer.is_stopped() and bullets > 0:
		shoot_sound.play()
		animations.play("shoot")
		firing_timer.start()
		bullets -= 1
		if raycast.is_colliding():
			raycast.get_collider().kill()
			bullets += raycast.get_collider().bullet
			return true


func damage():
	lifes -= 1
	velocity.y = -500

func death():
	#queue_free()
	print("morreu")


func _on_Area2D_body_exited(body):
	body.kill()
