extends Node2D

@export var enemy_scene : PackedScene
var _speed := 120.0


func _physics_process(delta):
	%PathFollow2D.set_progress(%PathFollow2D.get_progress() + _speed * delta)


func _on_enemy_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	%PathFollow2D.add_child(enemy)
	print("spawned")
