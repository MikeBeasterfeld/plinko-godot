extends HBoxContainer

var player_name = "Some Guy"
var player_score = "00000"

@onready var player = $Player
@onready var score = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	
func update_labels():
	player.text = player_name
	score.text = player_score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
