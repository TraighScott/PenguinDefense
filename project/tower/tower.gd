extends StaticBody2D


var cur_targets := []
var cur_target


func _on_area_2d_body_entered(body):
	print(body)
	#if "RigidBody2D" in body.name:
	#	var tempArray = []
	#	cur_targets = get_node("Towers").get_overlapping_bodies()
	#	
	#	print("yeh")
#

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
