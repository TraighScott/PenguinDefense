extends CharacterBody2D


@export var can_place: bool

var cur_targets := []
var curr: Node2D
var dragging := false
var of := Vector2.ZERO
var placed := false
var direction := Vector2(1,0) * 200
var id := 0

@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	if !placed:
		velocity = direction
	
	if is_instance_valid(curr) and !dragging:
		self.look_at(curr.global_position)
	
	if dragging:
		position = get_global_mouse_position() - of
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and placed == true:
		var temp_array := []
		cur_targets = $Area2D.get_overlapping_bodies()
		
		for i in cur_targets:
			if "Enemy" in i.name:
				temp_array.append(i)
		var cur_target: Node2D = null
		
		for i in temp_array:
			if cur_target == null:
				cur_target = i.get_node("../")
			else:
				if i.get_parent().get_progress() > cur_target.get_progress():
					cur_target = i.get_node("../")
		
		curr = cur_target


func _on_area_2d_body_exited(_body):
	cur_targets = $Area2D.get_overlapping_bodies()


func _on_shoot_timer_timeout() -> void:
	if is_instance_valid(curr) and !dragging:
		var impulse := Vector2(1, 0) * 700
		var projectile = preload("res://tower/projectile.tscn").instantiate()
		add_child(projectile)
		projectile.global_position = global_position
		


func _on_drag_button_button_down():
	if placed == false:
		dragging = true
		direction = Vector2.ZERO
		of = get_global_mouse_position() - global_position


func _on_drag_button_button_up():
	if can_place == true:
		dragging = false
		placed = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	if not dragging:
		print("Back to the water")
		queue_free()


func _on_tower_class_changed_direction(body):
	print("wah")
	if body.is_in_group("tower"):
		print("tower pass")
		direction = Vector2(0,1) * 200
