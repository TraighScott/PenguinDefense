extends Node2D


func game_music():
	$GameMusic.play()


func enemy_defeated_sound():
	$EnemyHitSound.play()


func tower_damaged_sound():
	$TowerHitSound.play()


func lose_sound():
	$GameMusic.stop()
	$LoseSound.play()


func win_sound():
	$GameMusic.stop()
	$WinSound.play()
