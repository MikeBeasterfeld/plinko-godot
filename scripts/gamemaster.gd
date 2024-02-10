extends Node2D

class_name PlinkoGameMaster

@onready var v_box_container: VBoxContainer = $scorepanel/ScrollContainer/VBoxContainer
var player_score: PackedScene = load("res://scene/player_score.tscn")
var ball_scene: PackedScene = load("res://scene/ball.tscn")
var alley_scene: PackedScene = load("res://scene/alley.tscn")

var count: int = -185

var alley_start: int = -193
var alley_space: int = 32

var scores: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_scores()
	create_alleys()
	create_balls()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func create_alleys() -> void:
	var alleys: PackedInt32Array = PackedInt32Array([0, 25, 125, 250, 500, 0, 1000, 0, 500, 250, 125, 25, 0])
	
	for alley: int in alleys:
		var instance: PlinkoAlley = alley_scene.instantiate()
		instance.initialize(
			Vector2(alley_start, 275),
			alley
		)
		alley_start = alley_start + alley_space
		#print(instance.find_child("Area2D"))
		instance.get_collider().area_entered.connect(add_score.bind(instance.SCORE))
		#instance.find_child("Area2D").area_entered.connect(add_score.bind(instance.SCORE))
		$alleys.add_child(instance)

func add_score(area: PlinkoBallArea2D, score: int) -> void:
	var player: String = area.get_ball_name()

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
	
func update_scores() -> void:
	for child: HBoxContainer in v_box_container.get_children():
		print("Delete " + child.name)
		child.queue_free()
		
	for player: String in scores:
		var score: int = scores[player]
		create_score(player, score)
	
func create_score(player: String, score: int) -> void:
	var instance: PlinkoPlayerScore = player_score.instantiate()
	instance.player = player
	instance.score = str(score)
		
	v_box_container.add_child(instance)

func create_ball(player_name: String, position: int) -> void:
	var instance: PlinkoBall = ball_scene.instantiate()
	instance.position = Vector2(position, -295)
	instance.BALL_NAME = player_name
	add_child(instance)
	

func _on_timer_timeout() -> void:
	create_balls()
		
func create_balls() -> void:
	var player_names: Array = ["Bob Burgers"]
	
	player_names.shuffle()
		
	count = -185
	
	for player: String in player_names:
		create_ball(player, 100)
	
#func find_fn(arr: Array, f: Callable):
	#for i in range(arr.size()):
		#if (f.call(i)):
			#return i
