extends Area2D

#@onready var level_manager: Node = %LevelManager
@onready var level_manager = get_node("/root/Game/LevelManager")

#The vision cone for the fysh might either be a raycast or area2d 
# or a secret third thing that a youtube video tells me

var SPEED := 50.0
var direction = 1 #We want to change the direction when the fysh collides with the wall or when it sees a bobber

#Not sure if this is the best method of "catching" a fysh since the cursor is going to be the tool too
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#Here I would call the minigame event as well
		#After the minigame I would either have the fish catch screen
		# or fish getting away screen
		
		#Since this is the prototype, this would be how the speargun works, 
		#but since theres gonna be multiple tools idk if the script should be on the fysh itself or its own seperate thing
		level_manager.add_point()
		queue_free()

func _process(delta: float) -> void:
	#have it roam around; see if theres a common roaming around function
	# also this will be an fsm where it will roam, but when it sees a bobber
	# it might get interested and start moving towards it instead
	#position.x += SPEED * delta * direction
	pass
