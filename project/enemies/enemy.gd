extends RigidBody2D

signal damaged_fort

var health := 1

func _process(_delta):
	if health == 0:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("projectile"):
		health -= 1


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("bleh")
	damaged_fort.emit()
	queue_free()
