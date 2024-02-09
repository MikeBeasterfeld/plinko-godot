extends HBoxContainer

@export var player = "Some Guy"
@export var score = "00000"

@onready var player_label = $Player
@onready var score_label = $Score

# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	
func update_labels():
	player_label.text = player
	score_label.text = score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
