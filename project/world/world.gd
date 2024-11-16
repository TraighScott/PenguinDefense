extends Node2D


signal enemy_spawned
signal changed_direction

@export var can_place := true

@onready var path = preload("res://enemy/path1.tscn")
@onready var tower_scene = preload("res://tower/tower.tscn")
@onready var fortress: Node2D = $Fortress
@onready var _time_left_in_game = $GameEndTimer.wait_time


func _physics_process(_delta: float) -> void:
	if fortress.health == 0:
		get_tree().change_scene_to_file("res://menus/end_menu.tscn")
	
	$FortressHealth.text = "Fortress Health %d/3" % fortress.health
	$RemainingTime.text = "Remaining Time: %d" % $GameEndTimer.time_left


func _on_enemy_spawn_timer_timeout():
	var enemy = path.instantiate()
	add_child(enemy)
	enemy_spawned.emit(enemy.enemy)


func _on_game_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://menus/win_menu.tscn")


#This is a problem to be remedied
func wave_management():
	if $GameEndTimer.time_left < (_time_left_in_game/1.25):
		$EnemySpawnTimer.wait_time -= .1
		_time_left_in_game = $GameEndTimer.wait_time


func _on_tower_timer_timeout():
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.position = $TowerClass.global_position
	
	$TowerTimer.wait_time = randf_range(1, 10)


func _on_area_2d_body_entered(body):
	if body.is_in_group("tower"):
		print('World pass')
		changed_direction.emit(body)


func _on_no_tower_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("tower"):
		body.can_place = false
		print("Can't place")


func _on_no_tower_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("tower"):
		body.can_place = true
		print("Can place")
