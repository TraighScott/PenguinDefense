extends Node2D


signal fortress_hit

@export var health := 3


func _on_world_enemy_spawned(enemy: Enemy) -> void:
	enemy.damaged_fort.connect(func():
		SoundController.tower_damaged_sound()
		health -= 1
		fortress_hit.emit()
		)
	


func _on_world_boss_spawned(boss: Boss) -> void:
	boss.damaged_fort.connect(func():
		SoundController.tower_damaged_sound()
		health = 0
		fortress_hit.emit()
		)
