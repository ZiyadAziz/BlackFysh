extends Area2D

@onready var level_manager = get_node("/root/Game/LevelManager")

# if a fish is hooked, then it initiates the minigame
# otherwise it just goes away

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and level_manager.bobber_out == true:
		level_manager.bobber_out = false
		get_viewport().set_input_as_handled() #Not sure if this will cause any other problems, honestly probably fixes any other problems that reeling in while clicking on a button would cause
		queue_free()
