extends Path2D


@onready var enemy: CharacterBody2D = $PathFollow2D/Enemy
@onready var fish := load("res://enemy/enemy_resources/fish.tres")
@onready var fast_fish := load("res://enemy/enemy_resources/fast_fish.tres")
@onready var tanky_fish := load("res://enemy/enemy_resources/tanky_fish.tres")


var roll := randi_range(1, 30)


func _ready() -> void:
	
	if enemy != null:
		if roll <= 15:
			enemy.load_enemy_type(fish)
		elif roll <= 22:
			enemy.load_enemy_type(fast_fish)
		else:
			enemy.load_enemy_type(tanky_fish)
