extends Node2D


@export var health := 3


func _on_world_enemy_spawned(enemy: Enemy) -> void:
	enemy.damaged_fort.connect(func ():
		health -= 1
		print("OW" + str(health))
		)
