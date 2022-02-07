extends ParallaxBackground

onready var layer1 = $ParallaxLayer
onready var layer2 = $ParallaxLayer2
onready var cloud1 = preload ("res://Scenes/clouds/cloud1.tscn")
onready var cloud2 = preload ("res://Scenes/clouds/cloud2.tscn")
onready var cloud3 = preload ("res://Scenes/clouds/cloud3.tscn")
onready var cloud4 = preload ("res://Scenes/clouds/cloud4.tscn")
onready var cloud5 = preload ("res://Scenes/clouds/cloud5.tscn")

#func _ready():
#	for i in 20:
#		spawn_cloud(rand_range(-100, 100), rand_range(-100,100))

func spawn_cloud(x, y):
	var which_cloud = int(rand_range(1, 5))
	var cloud 
	var global_pos = GLOBAL.player_position
	match which_cloud:
		1:
			cloud = cloud1.instance()
		2:
			cloud = cloud2.instance()
		3:
			cloud = cloud3.instance()
		4:
			cloud = cloud4.instance()
		5:
			cloud = cloud5.instance()
		_:
			cloud = cloud1.instance()

	global_pos.x += x
	if x > 0:
		cloud.dir = -1
	else:
		cloud.dir = 1
	global_pos.y += y
	cloud.global_position += global_pos
	if randf() < 0.5:
		layer1.add_child(cloud)
	else:
		layer2.add_child(cloud)


func _on_Timer_timeout():
	spawn_cloud(rand_range(-100, 100), rand_range(-100, 100))
