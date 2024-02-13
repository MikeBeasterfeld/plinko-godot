extends Node2D

@export var offset: Vector2 = Vector2(300, 0)
@export var duration: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_tween()

func start_tween():
	var move_tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	move_tween.set_loops().set_parallel(false)
	move_tween.tween_property($AnimatableBody2D, "position", offset, duration / 2)
	move_tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 2)
	
	#var rotation_tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	#rotation_tween.set_loops()
	#rotation_tween.tween_property($AnimatableBody2D, "rotation", 360, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
