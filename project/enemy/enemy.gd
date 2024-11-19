class_name Enemy extends CharacterBody2D


signal damaged_fort

@export var enemy_type : EnemyType

@onready var path: PathFollow2D = get_parent()
@onready var health
@onready var speed


func _physics_process(delta):
	if health <= 0:
		get_parent().get_parent().queue_free()
	path.set_progress(path.get_progress() + speed * delta)
	$EnemyHealth.text = "%d" % health


func load_enemy_type(new_enemy : EnemyType):
	enemy_type = new_enemy
	health = enemy_type.health
	speed = enemy_type.speed
	enemy_type.duplicate()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("bleh")
	damaged_fort.emit()
	get_parent().get_parent().queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		SoundController.enemy_defeated_sound()
		health -= 1
		body.queue_free()
