extends Node2D

onready var player = $Player
onready var camera = $Camera
var enemy_count = 1


func _ready():
	pass # Replace with function body.

func _process(delta):
	if player.velocity.y < 0 and player.position.y < camera.position.y:
		camera.position.y = player.position.y 
	print(enemy_count)
	pass

# enemy spawner
var fly = preload ("res://Scenes/Fly.tscn")

func _on_Timer_timeout():
	#var player = get_node("Path/To/Player")
	var e = fly.instance()
	var pos = player.position

	if randf() < 0.5:
		# On the left
		pos.x -= rand_range(50.0, 200.0)
	else:
		# On the right
		pos.x += rand_range(50.0, 200.0)
	
	pos.y += 50
	e.position = pos
	add_child(e)
