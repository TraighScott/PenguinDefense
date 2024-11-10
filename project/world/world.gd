extends Node2D


signal enemy_spawned

var _tower_limit := 0
var _can_place := true

@onready var path = preload("res://enemy/path1.tscn")
@onready var tower_scene = preload("res://tower/tower.tscn")
@onready var fortress: Node2D = $Fortress


func _physics_process(_delta: float) -> void:
	if fortress.health == 0:
		get_tree().change_scene_to_file("res://menus/end_menu.tscn")
	$FortressHealth.text = "Fortress Health %d/3" % fortress.health
		
	if Input.is_action_just_pressed("spawn_tower"):
		if _tower_limit < 5 and _can_place == true:
			var mouse_pos := get_global_mouse_position()
			var tower = tower_scene.instantiate()
			get_node("Towers").add_child(tower)
			tower.position = mouse_pos
			_tower_limit += 1
			$PlaceableTowers.text = "Placeable Towers: %d" % (5 - _tower_limit)
			
	$RemainingTime.text = "Remaining Time: %d" % $GameEndTimer.time_left


func _on_enemy_spawn_timer_timeout():
	var enemy = path.instantiate()
	add_child(enemy)
	enemy_spawned.emit(enemy.enemy)
	print("spawned")


func _on_game_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://menus/win_menu.tscn")


func _on_no_tower_area_mouse_entered() -> void:
	_can_place = false


func _on_no_tower_area_mouse_exited() -> void:
	_can_place = true
