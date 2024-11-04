extends Node2D


signal enemy_spawned

@onready var path = preload("res://enemy/enemy.tscn")
@onready var tower_scene = preload("res://tower/tower.tscn")
@onready var fortress: Node2D = $Fortress

var tower_limit := 0


func _physics_process(_delta: float) -> void:
	if fortress.health == 0:
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("spawn_tower"):
		if tower_limit < 5:
			var mouse_pos := get_global_mouse_position()
			var tower = tower_scene.instantiate()
			get_node("Towers").add_child(tower)
			tower.position = mouse_pos
			tower_limit += 1


func _on_enemy_spawn_timer_timeout():
	var enemy = path.instantiate()
	add_child(enemy)
	enemy_spawned.emit(enemy)
	print("spawned")
