extends HBoxContainer

class_name PlinkoPlayerScore

@export var player: String = "Some Guy"
@export var score: String = "00000"

@onready var player_label: Label = $Player
@onready var score_label: Label = $Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_labels()
	
func update_labels() -> void:
	player_label.text = player
	score_label.text = score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
