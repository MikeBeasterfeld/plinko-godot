extends Node2D

@export var SCORE = 0

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "[color=black]" + str(SCORE) + "[/color]"
	
	#$Area2D.area_entered.connect(_on_area_2d_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#func _on_area_2d_area_entered(area):
	#print("Points " + str(SCORE) + " name: " + name)
	#print(area)
	#print(area.get_parent().BALL_NAME)
