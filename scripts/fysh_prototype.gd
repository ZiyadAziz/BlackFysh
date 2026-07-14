extends CharacterBody2D

#@onready var level_manager: Node = %LevelManager
@onready var level_manager = get_node("/root/Game/LevelManager")
@onready var minigame_prototype = get_node("/root/Game/minigame_prototype")

#The vision cone for the fysh might either be a raycast or area2d (currently using area2d)
# or a secret third thing that a youtube video tells me
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var SPEED := 50.0
var speed_mult = 1
var direction = 1 #We want to change the direction when the fysh collides with the wall or when it sees a bobber

enum State {IDLE, INTEREST}
var current_state = State.IDLE

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and level_manager.current_tool == level_manager.Tools.SPEARGUN:
		#Here I would call the speargun minigame event
		#After the minigame I would either have the fish catch screen
		# or fish getting away screen
		
		#In the future this would be changed to be the minigame itself
		# need to actually make the minigame, but I think the minigame
		# somehow needs to return a true or false, and based on that
		# a menu would pop up with the fysh you caught or with a fail
		# message
		
		#When the minigame is occuring, I need to disable the tool so that I dont
		# click on anything aside from interacting with the minigame
		# (this could either be done by having like a minigame tool or disabling
		# the capability of the fysh to be interacted with; I think the first solution
		# might be easier by just having a tool called MINIGAME or something) 
		minigame_prototype.show()
		queue_free()

func _process(delta: float) -> void:
	#have it roam around; see if theres a common roaming around function
	# also this will be an fsm where it will roam, but when it sees a bobber
	# it might get interested and start moving towards it instead
	#position.x += SPEED * delta * direction
	
	#While idle: disable vision, burst of movement that is tweened, randomize the multiplier/distance and direction/rotation, and time to next movement, reenable vision
	# fish would also have to bounce off of the ground in a way that a pool ball would behave (not sure if this is a common function) 
	# requires editing rotation (look at space loop for that), the rotation should be randomized on ready
	
	if current_state == State.IDLE: 
		pass
		#position.x += SPEED * delta * direction
	pass
