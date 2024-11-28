extends Path2D


@onready var enemy: CharacterBody2D = $PathFollow2D/Enemy
@onready var fish := load("res://enemy/enemy_resources/fish.tres")
@onready var fast_fish := load("res://enemy/enemy_resources/fast_fish.tres")
@onready var tanky_fish := load("res://enemy/enemy_resources/tanky_fish.tres")
@onready var boss_fish := load("res://enemy/enemy_resources/boss_fish.tres")

var roll := randi_range(1, 30)


func _ready() -> void:
	#Need to figure out a way to spawn boss without randomization
	#if something:
		#roll = 0
	
	if roll == 0:
		enemy.load_enemy_type(boss_fish)
	elif roll <= 15:
		enemy.load_enemy_type(fish)
	elif roll <= 22:
		enemy.load_enemy_type(fast_fish)
	else:
		enemy.load_enemy_type(tanky_fish)
