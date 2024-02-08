extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var BOUNCE_POWER = .5
@export var BOUNCE_RANDOMNESS = .2
@export var BALL_NAME = "Jimmy Jam"

@onready var rich_text_label = $RichTextLabel
@onready var collision_shape_2d = $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rng = RandomNumberGenerator.new()

func _ready():
	rich_text_label.text = "[color=blue]" + BALL_NAME + "[/color]"
	set_velocity(Vector2(0,0))

func _physics_process(delta):
	if position.y > 299:
		queue_free()
		return
		
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal()) * (BOUNCE_POWER + rng.randf_range(0, BOUNCE_RANDOMNESS));

	else:
		#print("gravity: " + str(gravity))
		velocity.y += (gravity * .1) * delta
		
	#velocity = velocity.clamp(Vector2(-100, -1000), Vector2(100, 1000))
				
	#print("velocity")
	#print(velocity)
