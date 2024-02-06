extends Node2D

@export var SCORE = 0

@onready var label = $Label
#@onready var collision_shape_2d = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "[color=black]" + str(SCORE) + "[/color]"
	
	#var area2d = get_node("Area2D")
	#area2d.area_entered.connect(_on_area_2d_area_entered)
	
	$Area2D.area_entered.connect(_on_area_2d_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_area_entered(area):
	print("Points " + str(SCORE) + " name: " + name)
	print(area)
