extends Node2D

@onready var v_box_container = $scorepanel/ScrollContainer/VBoxContainer
var player_score = load("res://scene/player_score.tscn")
var ball_scene = load("res://scene/ball.tscn")
var alley_scene = load("res://scene/alley.tscn")

var count = -185

var alley_start = -193
var alley_space = 32

var scores = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	update_scores()
	create_alleys()
	create_balls()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func create_alleys():
	var alleys = [0, 25, 125, 250, 500, 0, 1000, 0, 500, 250, 125, 25, 0]
	
	for alley in alleys:
		var instance : Node2D = alley_scene.instantiate()
		instance.position = Vector2(alley_start, 275)
		alley_start = alley_start + alley_space
		instance.SCORE = alley
		print(instance.find_child("Area2D"))
		instance.find_child("Area2D").area_entered.connect(add_score.bind(instance.SCORE))
		$alleys.add_child(instance)

func add_score(area: Area2D, score: int):
	var player = area.get_parent().BALL_NAME

	if score == 0:
		return
		
	print("hit " + str(score) + " " + player)

	if scores.has(player):
		print("Starting score " + str(scores[player]))
		print("Adding score " + str(score))
		scores[player] = scores[player] + score
	else:
		print("Init " + player)
		scores[player] = score
		
	update_scores()
	
func update_scores():
	for child in v_box_container.get_children():
		print("Delete " + child.name)
		child.queue_free()
		
	for score in scores:
		create_score(score, scores[score])
	
func create_score(player: String, score: int):
	var instance : HBoxContainer = player_score.instantiate()
	instance.player = player
	instance.score = str(score)
		
	v_box_container.add_child(instance)

func create_ball(player_name: String):
	var instance : CharacterBody2D = ball_scene.instantiate()
	instance.position = Vector2(count, -295)
	count = count + 50
	instance.BALL_NAME = player_name
	add_child(instance)
	

func _on_timer_timeout():
	create_balls()
		
func create_balls():
	var player_names = ["Amy Adams", "Bob Burgers", "Carly Car", "Daniel Den", "Emmett Ear"]
	
	player_names.shuffle()
	
	var size = 5
	var start = 0
	var end = 4
	
	var get_element = func ():
		var current_player = player_names[start]
		start += 1
		return current_player
		
	var add_element = func (player):
		if end + 1 >= size:
			end = 0
		else:
			end = end + 1
			
		player_names[end] = player
		end += 1
	
	
	count = -185
	
	for player in player_names:
		create_ball(player)
	
func find_fn(arr: Array, f: Callable):
	for i in range(arr.size()):
		if (f.call(i)):
			return i
	
	
