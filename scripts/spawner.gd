extends Area2D

#This gives the spawner a fysh variable that I can put a scene into in the spawner inspector
@export var fysh_to_spawn: PackedScene 
@onready var game = get_node("/root/Game")
@onready var level_manager: Node = %LevelManager


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

#I think i need ready to call the spawning function when the scene is loaded
#it might also prep the spawner's boundries and stuff
func _ready() -> void:
	#spawn_fysh()
	pass


##On the asteroid game, I just have a timer for the spawner to start spawning
##This might not be the best solution since in the full game, I wouldn't want fysh
##to start spawning untill the specific scene is loaded
#For the function itself, all it should do is instanciate a fysh when its less
# than the max fysh amount in a random position within the boundries 
#I might need a timer/delay of sorts so that all the fysh dont spawn instantly

#func spawn_fysh() -> void:
	#while level_manager.fysh_count < level_manager.max_fysh:
		###LOOK MORE INTO HOW THESE LINES OF CODE WORKS, FOR KNOWLEDGE SAKE
		#var shape = collision_shape_2d.shape as RectangleShape2D
		#var size = shape.extents
		#var origin = collision_shape_2d.global_position
		#
		#var random_x = randf_range(origin.x - size.x, origin.x + size.x)
		#var random_y = randf_range(origin.y - size.y, origin.y + size.y)
	#
		#var fysh = fysh_to_spawn.instantiate()
		##Fysh might need to declare global_position as a variable
		#fysh.global_position = Vector2(random_x, random_y) 
		#get_parent().call_deferred("add_child", fysh)
		##Need to do call_deferred for some reason? 
		##game.add_child(fysh) 
		#level_manager.fysh_spawned()

#I dont think we want the spawner to spawn in every frame
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_timer_timeout() -> void:
	if level_manager.fysh_count < level_manager.max_fysh:
		##LOOK MORE INTO HOW THESE LINES OF CODE WORKS, FOR KNOWLEDGE SAKE
		var shape = collision_shape_2d.shape as RectangleShape2D
		var size = shape.extents
		var origin = collision_shape_2d.global_position
		
		var random_x = randf_range(origin.x - size.x, origin.x + size.x)
		var random_y = randf_range(origin.y - size.y, origin.y + size.y)
	
		var fysh = fysh_to_spawn.instantiate()
		#Fysh might need to declare global_position as a variable
		fysh.global_position = Vector2(random_x, random_y) 
		get_parent().add_child(fysh)
		level_manager.fysh_spawned()
