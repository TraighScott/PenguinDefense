class_name Boss extends CharacterBody2D


signal damaged_fort

@export var health: int
@export var speed: int

@onready var path: PathFollow2D = get_parent()


func _ready() -> void:
	$AnimationPlayer.play("swim")


func _physics_process(delta):
	if health <= 0:
		get_tree().change_scene_to_file("res://menus/win_menu.tscn")
		get_parent().get_parent().queue_free()
	path.set_progress(path.get_progress() + speed * delta)
	$BossHealth.text = "Health: %d" % health
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	damaged_fort.emit()
	get_parent().get_parent().queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		SoundController.enemy_defeated_sound()
		health -= 1
		body.queue_free()
