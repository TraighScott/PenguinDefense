class_name Enemy extends Path2D

signal damaged_fort

var _health := 1
var _speed := 120

@onready var path: PathFollow2D = $PathFollow2D

func _physics_process(delta):
	if _health == 0:
		queue_free()
	path.set_progress(path.get_progress() + _speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("bleh")
	damaged_fort.emit()
	queue_free()


func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("projectile"):
		_health -= 1
