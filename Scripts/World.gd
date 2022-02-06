extends Node2D

onready var player = $Player
onready var camera = $Camera
onready var label_score = $Camera/label_score

var player_start_position
var local_score

func _ready():
	player_start_position = player.get_position().y
	GLOBAL.enemy_count = 1
	
func _process(delta):
	local_score = (abs(player.get_position().y) - player_start_position) / 10
	if local_score > GLOBAL.current_score:
		GLOBAL.current_score = local_score
	if GLOBAL.current_score > GLOBAL.high_score:
		GLOBAL.high_score = GLOBAL.current_score
		GLOBAL.new_highscore = true
		
	
	label_score.text = str(int(GLOBAL.high_score))
	
	if player.velocity.y < 0 and player.position.y < camera.position.y:
		camera.position.y = player.position.y 
	#print(enemy_count)
	pass

# enemy spawner
onready var fly = preload ("res://Scenes/Fly.tscn")
onready var grub = preload ("res://Scenes/grub.tscn")
var side = true

func _on_Timer_fly_timeout():
	#var player = get_node("Path/To/Player")
	spawn_fly()

func spawn_grub():
	var e = grub.instance()
	var pos = player.position
	if randf() < 0.5:
		pos.x += rand_range(0, 100.0)
	else:
		pos.x -= rand_range(0, 100.0)
	pos.y -= 70
	
	if player.velocity.y < 0:
		e.velocity.y = player.velocity.y * 0.75
	else:
		e.velocity.y = 75
	e.position = pos
	add_child(e)

func spawn_fly():
	var e = fly.instance()
	var pos = player.position
	if side:
		pos.x += rand_range(0, 100.0)
		side = false
	else:
		pos.x -= rand_range(0, 100.0)
		side = true
	
	if player.velocity.y < 0:
		e.velocity.y = player.velocity.y * 0.50
		pos.y += rand_range(50, 100)
	else:
		e.velocity.y = -player.velocity.y * 0.80
		pos.y += rand_range(80, 120)
	
	e.position = pos
	add_child(e)
