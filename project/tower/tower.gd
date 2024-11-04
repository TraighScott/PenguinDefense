extends StaticBody2D


var cur_targets := []
var curr

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
		

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		var temp_array = []
		cur_targets = $Area2D.get_overlapping_bodies()
		
		for i in cur_targets:
			if "Enemy" in i.name:
				temp_array.append(i)
		var cur_target = null
		
		for i in temp_array:
			if cur_target == null:
				cur_target = i.get_node("../")
			else:
				if i.get_parent().get_progress() > cur_target.get_progress():
					cur_target = i.get_node("../")
		
		curr = cur_target
		print("In:" + str(cur_targets))
		
		
		

func _on_area_2d_body_exited(body):
	cur_targets = $Area2D.get_overlapping_bodies()
	print("Out: " + str(cur_targets))


func _on_shoot_timer_timeout() -> void:
	if is_instance_valid(curr):
		var impulse := Vector2(1, 0) * 100
		var projectile = preload("res://tower/projectile.tscn").instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = global_position
		projectile.apply_impulse(impulse.rotated(self.rotation*1))
		print(curr)
		
