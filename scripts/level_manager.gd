extends Node

var max_fysh := 20
var fysh_caught := 0
var fysh_count := 0

#This will be useful later, current tool is a speargun for now since I need to implement da rod
enum Tools {FYSHINGROD, NET, SPEARGUN}
var current_tool = Tools.SPEARGUN 

func fysh_spawned():
	fysh_count += 1
	
func add_point():
	fysh_caught += 1 
	fysh_count -= 1
	print(fysh_caught)
