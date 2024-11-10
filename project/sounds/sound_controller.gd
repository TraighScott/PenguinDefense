extends Node2D


func _ready() -> void:
	$GameMusic.play()


func enemy_defeated_sound():
	$EnemyHitSound.play()


func tower_damaged_sound():
	$TowerHitSound.play()
