extends Node2D

var ball_scene = load("res://scene/ball.tscn")

var count = -160

var scores = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var names = ["Amy Adams", "Bob Burgers", "Carly Car"]
	
	for name in names:
		print(name)
		create_ball(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_ball(name: String):
	var instance : CharacterBody2D = ball_scene.instantiate()
	print(instance.get_script())
	print(count)
	instance.position = Vector2(count, -295)
	count = count + 50
	instance.BALL_NAME = name
	add_child(instance)
