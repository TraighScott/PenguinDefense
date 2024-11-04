class_name Enemy extends CharacterBody2D

signal damaged_fort

var _health := 1
var _speed := 120

@onready var path: PathFollow2D = get_parent()

func _physics_process(delta):
	if _health == 0:
		get_parent().get_parent().queue_free()
	path.set_progress(path.get_progress() + _speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("bleh")
	damaged_fort.emit()
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		_health -= 1
		body.queue_free()
