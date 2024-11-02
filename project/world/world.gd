extends Node2D


signal enemy_spawned

@onready var path = preload("res://enemy/enemy.tscn")
@onready var fortress: Node2D = $Fortress


func _physics_process(_delta: float) -> void:
	if fortress.health == 0:
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
	

func _on_enemy_spawn_timer_timeout():
	var enemy = path.instantiate()
	add_child(enemy)
	enemy_spawned.emit(enemy)
	print("spawned")
