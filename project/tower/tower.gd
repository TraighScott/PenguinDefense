extends CharacterBody2D


@export var can_place: bool

var cur_targets := []
var curr: Node2D
var _dragging := false
var _aiming := false
var of := Vector2.ZERO
var aiming_of := Vector2.ZERO
var placed := false
var direction := Vector2(1,0) * 200

var max_distance := 150

@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	
	if !placed:
		velocity = direction
	
	if _dragging:
		position = get_global_mouse_position() - of
	
	if _aiming: 
		$Marker2D.position = get_global_mouse_position() - aiming_of.normalized()
		$Marker2D/AimButton.position = $Marker2D.position
	
	look_at($Marker2D.position)
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
	if is_instance_valid(curr) and !_dragging:
		var impulse := Vector2(1, 0) * 200
		var projectile = preload("res://tower/projectile.tscn").instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = global_position
		projectile.apply_impulse(impulse.rotated(rotation))



func _on_drag_button_button_down():
	if placed == false:
		_dragging = true
		direction = Vector2.ZERO
		of = get_global_mouse_position() - global_position


func _on_drag_button_button_up():
	if can_place == true:
		_dragging = false
		placed = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	if not _dragging:
		print("Back to the water")
		queue_free()

## Oh please, oh please. Fix this, marker does not like us so. The misery. Oh the misery.
func _on_aim_button_button_down() -> void:
	_aiming = true
	aiming_of = get_global_mouse_position() - $Marker2D.global_position.normalized()


func _on_aim_button_button_up() -> void:
	_aiming = false
