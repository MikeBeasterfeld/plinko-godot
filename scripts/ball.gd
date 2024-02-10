extends CharacterBody2D

class_name PlinkoBall

@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0
@export var BOUNCE_POWER: float = .5
@export var BOUNCE_RANDOMNESS: float = .2
@export var BALL_NAME: String = "Jimmy Jam"

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rich_text_label.text = "[color=blue]" + BALL_NAME + "[/color]"
	set_velocity(Vector2(0,0))

func _physics_process(delta: float) -> void:
	if position.y > 299:
		queue_free()
		return
		
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal()) * (BOUNCE_POWER + rng.randf_range(0, BOUNCE_RANDOMNESS));

	else:
		#print("gravity: " + str(gravity))
		velocity.y += (gravity * .1) * delta
		
	#velocity = velocity.clamp(Vector2(-100, -1000), Vector2(100, 1000))
				
	#print("velocity")
	#print(velocity)

