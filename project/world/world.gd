extends Node2D

signal enemy_spawned
signal boss_spawned

@export var can_place := true

var wave := 0

@onready var path = preload("res://enemy/path1.tscn")
@onready var boss_path = preload("res://boss/boss_path.tscn")
@onready var tower_scene = preload("res://tower/tower.tscn")
@onready var fortress: Node2D = $Fortress
@onready var _time_left_in_game = $GameEndTimer.wait_time
@onready var _game_timer: Timer = $GameEndTimer
@onready var _enemy_timer: Timer = $FishTimer
@onready var _wave_countdown_timer: Timer = $WaveCountdownTimer


func _physics_process(_delta: float) -> void:
	if fortress.health == 0:
		get_tree().change_scene_to_file("res://menus/end_menu.tscn")
	
	$CanvasLayer/HealthRemaining.text = "Fortress Health %d/3" % fortress.health
	$CanvasLayer/RemainingTime.text = "Wave Time Left: %d" % $GameEndTimer.time_left
	$CanvasLayer/CurrentWave.text = "Wave: %d" % (wave+1)
	$CanvasLayer/WavePause.text  = "Time Until Next Wave: %d" % _wave_countdown_timer.time_left


func _on_fish_timer_timeout():
	var enemy = path.instantiate()
	add_child(enemy)
	enemy.add_to_group("enemy")
	enemy_spawned.emit(enemy.enemy)
	
	
func _on_game_end_timer_timeout() -> void:
	wave += 1
	_enemy_timer.paused = true
	
	_time_left_in_game = 30
	if wave != 3:
		$CanvasLayer/WavePause.show()
		_wave_countdown_timer.wait_time = 10
		_wave_countdown_timer.start()
		await _wave_countdown_timer.timeout
		$CanvasLayer/WavePause.hide()
	_enemy_timer.paused = false
	_game_timer.start()
	
	if wave == 1:
		_enemy_timer.wait_time = 0.5
	elif wave == 2:
		_enemy_timer.wait_time = .25
	elif wave == 3:
		_enemy_timer.paused = true
		var boss = boss_path.instantiate()
		add_child(boss)
		boss.add_to_group("enemy")
		boss_spawned.emit(boss.boss)
	elif wave == 4:
		get_tree().change_scene_to_file("res://menus/win_menu.tscn")


func _on_tower_timer_timeout():
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.position = $TowerClass.global_position
	
	$TowerTimer.wait_time = randf_range(1, 10)


func _on_no_tower_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("tower"):
		body.can_place = false


func _on_no_tower_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("tower"):
		body.can_place = true


func _on_fortress_fortress_hit() -> void:
	$ScreenShake.play("screen_shake")
