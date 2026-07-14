#This file is just for testing code from outside sources to see if I can learn from and utilize them
extends CharacterBody2D

@onready var level_manager = get_node("/root/Game/LevelManager")
@onready var collision_shape_2d: CollisionShape2D = $vision/CollisionShape2D

enum State { IDLE, INTEREST }
var current_state = State.IDLE

# Swimming
var swim_direction: Vector2
var target_direction: Vector2

var current_speed := 0.0
var max_speed := 60.0
var turning_speed := 2.5

# Timers
var idle_timer := 0.0
var burst_timer := 0.0

func _ready():
	randomize()

	# Randomize fish personality
	max_speed = randf_range(45.0, 70.0)
	turning_speed = randf_range(1.5, 3.5)

	# Random starting direction
	var angle = randf() * TAU
	swim_direction = Vector2.RIGHT.rotated(angle)
	target_direction = swim_direction

	rotation = swim_direction.angle()

func _physics_process(delta):

	match current_state:
		State.IDLE:
			idle_swim(delta)

		State.INTEREST:
			# Add bobber behavior later
			pass

	velocity = swim_direction * current_speed

	move_and_slide()

	# Rotate sprite to face movement direction
	if velocity.length() > 1:
		rotation = velocity.angle()

	# Bounce off walls
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)

		# Reflect direction like a pool ball
		swim_direction = swim_direction.bounce(collision.get_normal()).normalized()
		target_direction = swim_direction

		# Push away from the wall so we don't immediately collide again
		global_position += collision.get_normal() * 2.0

		break

func idle_swim(delta):

	idle_timer -= delta

	# Choose a new direction every few seconds
	if idle_timer <= 0:

		idle_timer = randf_range(1.0, 3.5)

		var turn_amount = deg_to_rad(
			randf_range(-80.0, 80.0)
		)

		target_direction = swim_direction.rotated(
			turn_amount
		).normalized()

		burst_timer = randf_range(0.2, 0.8)

	# Burst of speed
	if burst_timer > 0:

		burst_timer -= delta

		current_speed = move_toward(
			current_speed,
			max_speed,
			180.0 * delta
		)

	# Coast
	else:

		current_speed = move_toward(
			current_speed,
			15.0,
			30.0 * delta
		)

	# Smooth turning
	swim_direction = swim_direction.slerp(
		target_direction,
		turning_speed * delta
	).normalized()

	# Tiny wobble so movement isn't perfectly smooth
	var wobble = deg_to_rad(randf_range(-3.0, 3.0))
	swim_direction = swim_direction.rotated(wobble * delta)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:

	if event is InputEventMouseButton \
	and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and level_manager.current_tool == level_manager.Tools.SPEARGUN:

		level_manager.add_point()
		queue_free()
