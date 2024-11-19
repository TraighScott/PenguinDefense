extends Path2D


@onready var enemy: CharacterBody2D = $PathFollow2D/Enemy
@onready var fish := load("res://enemy/fish.tres")
@onready var fast_fish := load("res://enemy/fast_fish.tres")
@onready var tanky_fish := load("res://enemy/tanky_fish.tres")


func _ready() -> void:
	var roll = randi_range(1, 30)
	
	if roll <= 15:
		print("Wow I'm fish")
		enemy.load_enemy_type(fish)
	elif roll <= 22:
		print("Wow I'm fast")
		enemy.load_enemy_type(fast_fish)
	else:
		print("Wow I'm Tanky")
		enemy.load_enemy_type(tanky_fish)
