extends Area2D

@onready var level_manager: Node = %LevelManager

#Not sure if this is the best method of "catching" a fysh since the cursor is going to be the tool too
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#Here I would call the minigame event as well
		#Since this is the prototype, this would be how the speargun works, 
		#but since theres gonna be multiple tools idk if the script should be on the fysh itself or its own seperate thing
		level_manager.add_point()
		queue_free()
