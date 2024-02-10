extends Node2D

class_name PlinkoAlley

@export var SCORE: int = 0
@onready var label: RichTextLabel = $Label
 
func initialize(initPosition: Vector2, initScore: int) -> void:
	position = initPosition
	SCORE = initScore
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "[color=black]" + str(SCORE) + "[/color]"
	
	#$Area2D.area_entered.connect(_on_area_2d_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_collider() -> Area2D:
	var area: Variant = find_child("Area2D")
	assert(area != null)
	return area

#func _on_area_2d_area_entered(area):
	#print("Points " + str(SCORE) + " name: " + name)
	#print(area)
	#print(area.get_parent().BALL_NAME)
