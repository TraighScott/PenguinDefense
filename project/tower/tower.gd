extends CharacterBody2D


@export var can_place: bool

var _cur_targets := []
var _curr: Node2D
var _dragging := false
var _of := Vector2.ZERO
var _placed := false
var _direction := Vector2(1,0) * 200
var _id := 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var shoot_timer: Timer = $ShootTimer


func _ready() -> void:
	var roll = randi_range(1,10)
	
	if roll <= 7:
		_id = 1
	else: 
		_id = 2
	
	if _id == 2:
		sprite.modulate = Color.BLUE
		shoot_timer.wait_time = 2


func _physics_process(_delta: float) -> void:
	
	if !_placed:
		velocity = _direction
	
	if is_instance_valid(_curr) and !_dragging and _id == 1:
		self.look_at(_curr.global_position)
	
	if _dragging:
		position = get_global_mouse_position() - _of
	
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and _placed == true:
		var temp_array := []
		_cur_targets = $Area2D.get_overlapping_bodies()
		
		for i in _cur_targets:
			if "Enemy" in i.name:
				temp_array.append(i)
		var cur_target: Node2D = null
		
		for i in temp_array:
			if cur_target == null:
				cur_target = i.get_node("../")
			else:
				if i.get_parent().get_progress() > cur_target.get_progress():
					cur_target = i.get_node("../")
		
		_curr = cur_target


func _on_area_2d_body_exited(body):
	_cur_targets.erase(body)
	#_cur_targets = $Area2D.get_overlapping_bodies()


func _on_shoot_timer_timeout() -> void:
	if is_instance_valid(_curr) and !_dragging:
		if _id == 1:
			print("blam1")
			var projectile: CharacterBody2D = preload("res://tower/projectile.tscn").instantiate()
			add_child(projectile)
			projectile.global_position = global_position
		elif _id == 2:
			print("blam2")
			var aoe: StaticBody2D = preload("res://tower/aoe_projectile.tscn").instantiate()
			add_child(aoe)
			aoe.global_position = global_position


func _on_drag_button_button_down():
	if _placed == false:
		_dragging = true
		_direction = Vector2.ZERO
		_of = get_global_mouse_position() - global_position


func _on_drag_button_button_up():
	if can_place == true:
		_dragging = false
		_placed = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	if not _dragging:
		print("Back to the water")
		queue_free()
